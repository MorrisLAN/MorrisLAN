{ config, modulesPath, pkgs, lib, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    consoleLogLevel = lib.mkDefault 7;
    kernelModules = [ "kvm-intel" ];
    initrd.kernelModules = [];
    initrd.availableKernelModules = [ "ahci" "xhci_pci" "ehci_pci" "megaraid_sas" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/a7a755da-54e5-4adc-a57a-2e7572031de6";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/D876-A395";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  # systemd.services."sync-esp" = {
  #   description = "Synchronize ESP partitions";
  #   after = [ "boot.mount" ];
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = "${pkgs.rsnapshot}/bin/rsync -a --delete /boot/ /boot2/";
  #     RemainAfterExit = true;
  #   };
  # };

}