{ config, pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [ git github-runner ];
  file."/etc/ssl/private/gh-runner-token" = {
    text = ''
    SECRET_GH_RUNNER_TOKEN
    '';
    permissions = 0644;
  };
  services.github-runners = {
    home-aarch64 = {
      enable = true;
      name = "home-aarch64";
      tokenFile = "/etc/ssl/private/gh-runner-token";
      url = "https://github.com/MorrisLAN";
    };
  };
}