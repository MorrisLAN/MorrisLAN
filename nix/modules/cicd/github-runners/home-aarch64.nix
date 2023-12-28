{ config, pkgs, lib, ... }: {
  imports = [
    ../cicd.nix
  ];

  environment.systemPackages = with pkgs; [ github-runner ];

  environment.etc.gh-runner-token = {
    text = "SECRET_GH_RUNNER_TOKEN";
    mode = "0600";
    user = "cicd";
  };

  services.github-runners = {
    home-aarch64 = {
      name = "home-aarch64";
      enable = true;
      replace = true;
      user = "cicd";
      workDir = "/build";
      tokenFile = "/etc/gh-runner-token";
      url = "https://github.com/MorrisLAN";
    };
  };
}