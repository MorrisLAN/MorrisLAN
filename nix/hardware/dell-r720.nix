{ config, modulesPath, pkgs, lib, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;

  boot = {
    consoleLogLevel = lib.mkDefault 7;
    kernelModules = [ "kvm-intel" ];
    initrd.kernelModules = [];
    initrd.availableKernelModules = [ "ahci" "xhci_pci" "ehci_pci" "megaraid_sas" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
    loader.grub = {
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
    };
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/87C7-BBB9";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
    "/boot2" = {
      device = "/dev/disk/by-uuid/880C-6445";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
    "/" = {
      device = "bootpool/root";
      fsType = "zfs";
    };
    "/nix" = {
      device = "bootpool/nix";
      fsType = "zfs";
    };
    # "/data" = {
    #   device = "data";
    #   fsType = "zfs";
    # };
  };

  systemd.services."sync-esp" = {
    description = "Synchronize ESP partitions";
    after = [ "boot.mount" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.rsnapshot}/bin/rsync -a --delete /boot/ /boot2/";
      RemainAfterExit = true;
    };
  };

}
