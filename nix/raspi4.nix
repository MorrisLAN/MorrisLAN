{ config, pkgs, lib, ... }: {
  nixpkgs.localSystem.system = "aarch64-linux";
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/sd-image.nix>
    ./configuration.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_rpi4;
    loader.grub.enable = false;
    loader.generic-extlinux-compatible.enable = true;
    consoleLogLevel = lib.mkDefault 7;
    kernelParams =
      [ "console=ttyS0,115200n8" "console=ttyAMA0,115200n8" "console=tty0" ];
    initrd.availableKernelModules = [
      "vc4"
      "bcm2835_dma"
      "i2c_bcm2835"
    ];
  };
  
  services.openssh.enable = true;

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  users.defaultUserShell = pkgs.zsh;
  users.mutableUsers = false;
  users.users = {
    admin = {
      uid = 1000;
      home = "/home/admin";
      name = "admin";
      group = "admin";
      shell = pkgs.zsh;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHjgkh0LyGVjWzYnCxrKC5dxQMHE3ky7s/vFpAyjfk5l"
      ];
    };
  };

  sdImage = {
    populateFirmwareCommands = let
      configTxt = pkgs.writeText "config.txt" ''
        [pi3]
        kernel=u-boot-rpi3.bin
        [pi4]
        kernel=u-boot-rpi4.bin
        enable_gic=1
        armstub=armstub8-gic.bin
        [all]
        arm_64bit=1
        enable_uart=1
        avoid_warnings=1
      '';
    in ''
      (cd ${pkgs.raspberrypifw}/share/raspberrypi/boot && cp bootcode.bin fixup*.dat start*.elf $NIX_BUILD_TOP/firmware/)
      cp ${configTxt} firmware/config.txt
      cp ${pkgs.ubootRaspberryPi3_64bit}/u-boot.bin firmware/u-boot-rpi3.bin
      cp ${pkgs.ubootRaspberryPi4_64bit}/u-boot.bin firmware/u-boot-rpi4.bin
      cp ${pkgs.raspberrypi-armstubs}/armstub8-gic.bin firmware/armstub8-gic.bin
      cp ${pkgs.raspberrypifw}/share/raspberrypi/boot/bcm2711-rpi-4-b.dtb firmware/
    '';
    populateRootCommands = ''
      mkdir -p ./files/boot
      ${config.boot.loader.generic-extlinux-compatible.populateCmd} -c ${config.system.build.toplevel} -d ./files/boot
    '';
  };

}