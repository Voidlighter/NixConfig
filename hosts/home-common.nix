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
    ../home/bash.nix
    ./apps.nix
    # inputs.musnix.nixosModules.musnix
  ];

  # config = {
  # # users.${config.my.user.name} = {
  xdg.mimeApps = let
    browser = "one.ablaze.floorp.desktop";
  in {
    enable = true;

    # pick the Flatpak desktop ID once so you only type it in one place
    defaultApplications = {
      "x-scheme-handler/http" = browser;
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
      "x-scheme-handler/http" = browser;
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
      EDITOR = "${lib.getExe pkgs.neovim}";
      BROWSER = "xdg-open"; # respects your xdg.mimeApps default (one.ablaze.floorp.desktop)
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

    starship = {
      enable = true;
      # enableBashIntegration = true;
      # enableInteractive = true;
      # settings = {
      #   aws.disabled = true;
      #   gcloud.disabled = true;
      #   kubernetes.disabled = false;
      #   git_branch.style = "242";
      #   directory.style = "blue";
      #   directory.truncate_to_repo = false;
      #   directory.truncation_length = 8;
      #   python.disabled = true;
      #   ruby.disabled = true;
      #   hostname.ssh_only = false;
      #   hostname.style = "bold green";
      # };
    };
  };
  xdg.configFile."starship.toml".source = lib.mkForce ../home/starship.toml;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
  # # };
  # };
}
