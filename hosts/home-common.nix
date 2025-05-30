{
  config,
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
    # ../modules/home-manager/starship
    ../modules/bash
    ../modules/apps.nix
    # inputs.musnix.nixosModules.musnix
  ];

  # config = {
  # users.${config.my.user.name} = {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/xml" = "floorp.desktop";
      "text/html" = "floorp.desktop";
      "x-scheme-handler/ftp" = "floorp.desktop";
      "x-scheme-handler/http" = "floorp.desktop";
      "x-scheme-handler/https" = "floorp.desktop";
      "x-scheme-handler/chrome" = "floorp.desktop";
      "application/xhtml+xml" = "floorp.desktop";
      "application/x-extension-htm" = "floorp.desktop";
      "application/x-extension-html" = "floorp.desktop";
      "application/x-extension-shtml" = "floorp.desktop";
      "application/x-extension-xhtml" = "floorp.desktop";
      "application/x-extension-xht" = "floorp.desktop";
    };
    associations.added = {
      "text/xml" = "floorp.desktop";
      "text/html" = "floorp.desktop";
      "x-scheme-handler/ftp" = "floorp.desktop";
      "x-scheme-handler/http" = "floorp.desktop";
      "x-scheme-handler/https" = "floorp.desktop";
      "x-scheme-handler/chrome" = "floorp.desktop";
      "application/xhtml+xml" = "floorp.desktop";
      "application/x-extension-htm" = "floorp.desktop";
      "application/x-extension-html" = "floorp.desktop";
      "application/x-extension-shtml" = "floorp.desktop";
      "application/x-extension-xhtml" = "floorp.desktop";
      "application/x-extension-xht" = "floorp.desktop";
    };
  };
  home = {
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    # basically don't change this. It isn't the version number
    stateVersion = "24.05";
    username = "${config.my.user.name}";
    homeDirectory = "/home/${config.my.user.name}";

    sessionVariables = {
      EDITOR = "${lib.getExe pkgs.neovim}";
      BROWSER = "${lib.getExe pkgs.floorp}";
      # TERMINAL = "${lib.getExe pkgs.kitty}";
    };
    
    packages = config.my.apps.home;
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

    starship = {
      enable = true;
      enableBashIntegration = true;
      enableInteractive = true;
      settings = {
        aws.disabled = true;
        gcloud.disabled = true;
        kubernetes.disabled = false;
        git_branch.style = "242";
        directory.style = "blue";
        directory.truncate_to_repo = false;
        directory.truncation_length = 8;
        python.disabled = true;
        ruby.disabled = true;
        hostname.ssh_only = false;
        hostname.style = "bold green";
      };
    };
    config.xdg.configFile."starship.toml".source = lib.mkForce ../config/starship.toml;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
  # };
  #   };
  # };
}
