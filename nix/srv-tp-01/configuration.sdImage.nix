{ config, lib, pkgs, ... }: {
  sdImage.compressImage = false;
  nixpkgs.localSystem.system = "x86_64-linux";
  imports = [
    <nixpkgs/nixos/modules/virtualisation/digitalocean-image.nix>
    ./configuration.nix
  ];
  boot.kernelPackages = pkgs.linuxPackages;

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

}
