{
  config,
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
    ../home/bash.nix
    ./apps.nix
    # inputs.musnix.nixosModules.musnix
  ];

  # config = {
  # # users.${config.my.user.name} = {
  xdg.mimeApps = let browser = "one.ablaze.floorp.desktop"; in {
    enable = true;

    # pick the Flatpak desktop ID once so you only type it in one place
    defaultApplications = {
      "x-scheme-handler/http"  = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/chrome" = browser;
      "text/html" = browser;
      "text/xml" = browser;
      "application/xhtml+xml" = browser;
      "application/x-extension-htm" = browser;
      "application/x-extension-html" = browser;
      "application/x-extension-shtml" = browser;
      "application/x-extension-xhtml" = browser;
      "application/x-extension-xht" = browser;
    };

    associations.added = {
      "x-scheme-handler/http"  = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/chrome" = browser;
      "text/html" = browser;
      "text/xml" = browser;
      "application/xhtml+xml" = browser;
      "application/x-extension-htm" = browser;
      "application/x-extension-html" = browser;
      "application/x-extension-shtml" = browser;
      "application/x-extension-xhtml" = browser;
      "application/x-extension-xht" = browser;
    };
  };
  home = {
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    # basically don't change this. It isn't the version number
    stateVersion = "24.05";
    username = "${osConfig.my.user.name}";
    homeDirectory = "/home/${osConfig.my.user.name}";

    sessionVariables = {
      EDITOR  = "${lib.getExe pkgs.neovim}";
      BROWSER = "xdg-open";  # respects your xdg.mimeApps default (one.ablaze.floorp.desktop)
      # TERMINAL = "${lib.getExe pkgs.kitty}";
    };

    packages = osConfig.my.apps.home;

    file = {
      ".config/nixpkgs" = {
        source = ../home/nixpkgs;
        recursive = true;
      };
    };
  };

  fonts.fontconfig.enable = true;

  programs = {
    home-manager = {
      enable = true;
    };

    git = {
      enable = true;
      userName = "voidlighter";
      userEmail = "voidlighter@proton.me";
      aliases = {};
    };

    neovim = {
      enable = true;
      # viAlias = true;
      # vimAlias = true;
      # vimdiffAlias = true;
    };

    nix-index.enable = true;
    # nix-index.enableZshIntegration = true;
    nix-index.enableBashIntegration = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
  # # };
  # };
}
