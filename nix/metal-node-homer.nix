{ modulesPath, config, pkgs, lib, ... }: {
  imports = [
    ./hardware/dell-r730.nix
    ./modules/base.nix
    ./modules/k8s/metal/node.nix
  ];

  networking = {
    hostName = "metal-node-homer";
    bonds.bond0 = {
      interfaces = [ "eno1" "eno2" ];
      driverOptions = {
        mode = "802.3ad";
        miimon = "100";
        lacp_rate = "fast";
      };
    };
    interfaces.bond0 = {
      ipv4.addresses = [{
       address = "10.1.240.5";

       prefixLength = 24;
      }];
    };
    defaultGateway = "10.1.240.1";
    nameservers = [ "10.1.240.1" ];
  };

  system.stateVersion = "24.05";
}
