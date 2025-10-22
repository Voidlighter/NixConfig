{ config, pkgs, me, ... }:
{
  home.username = me.username;
  home.homeDirectory = "/home/${me.username}";
  home.stateVersion = "25.05";

  programs.git.enable = true;
  programs.bash = {
    enable = true;
  };
}