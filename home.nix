{ inputs, config, lib, pkgs, me, ... }: {
  imports = [ ./options.nix ];

  config = {
    home = {
      username = me.username;
      homeDirectory = "/home/${me.username}";
      stateVersion = me.stateVersion;

      sessionVariables = {
        EDITOR = "${lib.getExe pkgs.vim}";
        BROWSER = "${lib.getExe pkgs.mullvad-browser}";
        TERMINAL = "${lib.getExe pkgs.ghostty}";
      };

      packages = with pkgs;
        [
	  # (pkgs.writeShellApplication {
	  #   name = "ns";
	  #   runtimeInputs = with pkgs; [
	  #     fzf
	  #     nix-search-tv
	  #   ];
	  #   text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
	  # })
          libreoffice
          obsidian
          signal-desktop
          spotify
          zoom-us
          obs-studio
          python3
          nixfmt-classic
          alejandra
        ] ++ config.my.apps ++ (if config.my.minimal == false then
          with pkgs; [
            deadnix
            statix
            nil
            biome
            clang
            ccls # c / c++
          ]
        else
          [ ]);
    };

    programs = {
      bash = {
        enable = true;
        shellAliases = {
          btw = "echo 'i use hyprland btw'";
        };
        profileExtra = ''
          exec hyperland
        '';
      };
      git = {
        enable = true;
        settings.user = {
          name = me.username;
          email = me.email;
        };
      };

      nix-index.enable = true;
      nix-index.enableBashIntegration = true;

      starship = { enable = true; };
    };

    xdg.configFile."starship.toml".source = ./dot/starship.toml;

    home.file.".config/hypr".source = ./dot/hypr;
    home.file.".config/waybar".source = ./dot/waybar;
    home.file.".config/foot".source = ./dot/foot;

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";
  };
}
