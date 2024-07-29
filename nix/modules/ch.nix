{ config, pkgs, lib, ... }: {

  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [ docker-compose git ];
  
  environment.etc."morrislan".source = builtins.fetchGit {
    url = "https://ci:SECRETS.GIT_PAT@git.morrislan.net/MorrisLAN/morrislan.git";
    rev = "main";
  };

}
