{ config, pkgs, ... }:
{
  home.username = "cade";
  home.homeDirectory = "/home/cade";
  programs.git.enable = true;
  home.stateVersion = "25.05";
  programs.bash = {
    enable = true;
  };
}