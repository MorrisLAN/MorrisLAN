{ config, pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [ git github-runner ];
  environment.etc.gh-runner-token = {
    text = "SECRET_GH_RUNNER_TOKEN";
    mode = 0644;
  };
  services.github-runners = {
    home-aarch64 = {
      enable = true;
      name = "home-aarch64";
      tokenFile = "/etc/gh-runner-token";
      url = "https://github.com/MorrisLAN";
    };
  };
}
