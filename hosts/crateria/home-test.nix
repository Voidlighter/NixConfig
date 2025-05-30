{
  config,
  pkgs,
  ...
}: {
  home = {
    username = "cade";
    homeDirectory = "/home/cade";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}