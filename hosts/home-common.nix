{
  osConfig,
  inputs,
  lib,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    # nix-index-database.hmModules.nix-index
    inputs.plasma-manager.homeManagerModules.plasma-manager
    ../modules/starship
    ../modules/bash
    ../modules/apps.nix
    # inputs.musnix.nixosModules.musnix
  ];

  # config = {
  # users.${osConfig.my.user.name} = {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/xml" = "${lib.getExe pkgs.floorp}";
      "text/html" = "${lib.getExe pkgs.floorp}";
      "x-scheme-handler/ftp" = "${lib.getExe pkgs.floorp}";
      "x-scheme-handler/http" = "${lib.getExe pkgs.floorp}";
      "x-scheme-handler/https" = "${lib.getExe pkgs.floorp}";
      "x-scheme-handler/chrome" = "${lib.getExe pkgs.floorp}";
      "application/xhtml+xml" = "${lib.getExe pkgs.floorp}";
      "application/x-extension-htm" = "${lib.getExe pkgs.floorp}";
      "application/x-extension-html" = "${lib.getExe pkgs.floorp}";
      "application/x-extension-shtml" = "${lib.getExe pkgs.floorp}";
      "application/x-extension-xhtml" = "${lib.getExe pkgs.floorp}";
      "application/x-extension-xht" = "${lib.getExe pkgs.floorp}";
    };
    associations.added = {
      "text/xml" = "${lib.getExe pkgs.floorp}";
      "text/html" = "${lib.getExe pkgs.floorp}";
      "x-scheme-handler/ftp" = "${lib.getExe pkgs.floorp}";
      "x-scheme-handler/http" = "${lib.getExe pkgs.floorp}";
      "x-scheme-handler/https" = "${lib.getExe pkgs.floorp}";
      "x-scheme-handler/chrome" = "${lib.getExe pkgs.floorp}";
      "application/xhtml+xml" = "${lib.getExe pkgs.floorp}";
      "application/x-extension-htm" = "${lib.getExe pkgs.floorp}";
      "application/x-extension-html" = "${lib.getExe pkgs.floorp}";
      "application/x-extension-shtml" = "${lib.getExe pkgs.floorp}";
      "application/x-extension-xhtml" = "${lib.getExe pkgs.floorp}";
      "application/x-extension-xht" = "${lib.getExe pkgs.floorp}";
    };
  };
  home = {
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    # basically don't change this. It isn't the version number
    stateVersion = "24.05";
    username = "${osConfig.my.user.name}";
    homeDirectory = "/home/${osConfig.my.user.name}";

    sessionVariables = {
      EDITOR = "${lib.getExe pkgs.neovim}";
      BROWSER = "${lib.getExe pkgs.floorp}";
      # TERMINAL = "${lib.getExe pkgs.kitty}";
    };
    
    packages = osConfig.my.apps.home;
  };

  fonts.fontconfig.enable = true;

  programs = {
    home-manager = {
      enable = true;
      # useGlobalPkgs = true;
    };

    git = {
      enable = true;
      userName = "voidlighter";
      userEmail = "voidlighter@proton.me";
      aliases = {};
    };

    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };

    nix-index.enable = true;
    nix-index.enableZshIntegration = true;
    #     nix-index-database.comma.enable = true;

    konsole = {
      enable = true;
    };
    eza = {
      enable = true;
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
  # };
  #   };
  # };
}
