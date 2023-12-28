{ config, pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [ git github-runner ];

  users.users = {
    github-runner = {
      group = "github-runner";
      isSystemUser = true;
    };
  };
  users.groups.github-runner = { };

  environment.etc.gh-runner-token = {
    text = "SECRET_GH_RUNNER_TOKEN";
    mode = "0644";
  };
  services.github-runners = {
    home-aarch64 = {
      name = "home-aarch64";
      enable = true;
      replace = true;
      user = "github-runner";
      workDir = "/build";
      tokenFile = "/etc/gh-runner-token";
      url = "https://github.com/MorrisLAN";
    };
  };

  systemd.tmpfiles.rules = [
    "d /build 0600 github-runner github-runner -"
  ];

}
