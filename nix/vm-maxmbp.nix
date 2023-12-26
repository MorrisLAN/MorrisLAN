{ config, pkgs, lib, ... }: {
  imports = [
    <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
    ./modules/base.nix
  ];

  boot = {
    consoleLogLevel = lib.mkDefault 7;
    loader.grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
    };
    kernelParams = [ "console=ttyAMA0,115200n8" "console=tty0" ];
  };

  nixpkgs = {
    localSystem.system = "aarch64-linux";
    overlays = [
      (final: super: {
        makeModulesClosure = x:
          super.makeModulesClosure (x // { allowMissing = true; });
      })
    ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/vda2";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/vda1";
      fsType = "vfat";
    };
  };

  networking = {
    hostName = "vm-maxmbp";
    interfaces.enp0s5 = {
      useDHCP = true;
    };
  };

  system.build.image = import <nixpkgs/nixos/lib/make-disk-image.nix> {
    diskSize = 10000;
    format = "qcow2-compressed";
    installBootLoader = true;
    partitionTableType = "efi";
    inherit config lib pkgs;
  };

  system.stateVersion = "23.11";
}