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
          libreoffice
          obsidian
          signal-desktop
          spotify
          zoom-us
          obs-studio
          python3
          nixfmt-classic
          alejandra
        ] ++ (if config.my.minimal == false then
          with pkgs; [
            deadnix
            statix
            nil
            biome
            clang
            ccls # c / c++
          ]
        else
          [ ]) ++ config.my.apps;
    };

    programs = {
      bash.enable = true;

      git = {
        enable = true;
        userName = me.username;
        userEmail = me.email;
      };

      nix-index.enable = true;
      nix-index.enableBashIntegration = true;

      starship = { enable = true; };
    };
    xdg.configFile."starship.toml".source = ./dot/starship.toml;

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";
  };
}
