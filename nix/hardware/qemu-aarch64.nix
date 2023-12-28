# Build Command
# nix-build -I "nixpkgs=channel:nixos-23.11,nixos-config=./nix/machine.nix" '<nixpkgs>/nixos' -A config.system.build.image

{ config, modulesPath, pkgs, lib, ... }: {
  imports = [
    <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
  ];

  nixpkgs.localSystem.system = "aarch64-linux";

  boot = {
    kernelParams = ["console=ttyAMA0,115200n8" "console=tty0"];
    consoleLogLevel = lib.mkDefault 7;
    growPartition = true;
    initrd.kernelModules = [ "nvme" ];
    loader.grub = {
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
    };
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/vda1";
      fsType = "vfat";
    };
    "/" = {
      device = "/dev/vda2";
      fsType = "ext4";
      autoResize = true;
    };
  };


  system.build.image = import <nixpkgs/nixos/lib/make-disk-image.nix> {
    diskSize = 10000;
    format = "qcow2-compressed";
    installBootLoader = true;
    partitionTableType = "efi";
    inherit config lib pkgs;
  };
}
