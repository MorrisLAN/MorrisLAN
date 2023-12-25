{ config, lib, pkgs, ... }: {
  sdImage.compressImage = false;
  nixpkgs.localSystem.system = "x86_64-linux";
  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image.nix>
    ./configuration.nix
  ];
  boot.kernelPackages = pkgs.linuxPackages;
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  boot.consoleLogLevel = lib.mkDefault 7;
 
  boot.kernelParams =
    [ "console=ttyS0,115200n8" "console=tty0" ];

  boot.initrd.availableKernelModules = [
    "virtio_pci"
    "virtio_blk"
    "virtio_net"
  ];

  nixpkgs.overlays = [
    (final: super: {
      makeModulesClosure = x:
        super.makeModulesClosure (x // { allowMissing = true; });
    })
  ];

  sdImage = {
    populateRootCommands = ''
      mkdir -p ./files/boot
      ${config.boot.loader.generic-extlinux-compatible.populateCmd} -c ${config.system.build.toplevel} -d ./files/boot
    '';
  };

}
