{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  options.my = {
    app-group-selection = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = lib.attrNames (config.all-apps);
    };
    app-list = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = lib.concatLists (
        lib.attrValues (
          lib.getAttrs
          (config.my.app-group-selection)
          (config.my.all-apps)
        )
      );
    };
    all-apps = lib.mkOption {
      type = lib.types.attrs;
      default = {
        system = with pkgs; [
          neovim
          # inputs.pkgsStable.legacyPackages.${pkgs.system}.vim
          zsh
          wget
          git
          bat
          curl
          eza
          fd
          ripgrep
          zellij
          bottom
          zoxide
          fzf
          # zsh-powerlevel10k
          starship
          alacritty
          xorg.xkill
          firefox
        ];
        extraUtils = with pkgs; [
          neofetch.out
          hello
          qdirstat # Graphical disk usage analyzer
          # Nix UI: Snowfallorg
          inputs.nixos-conf-editor.packages.${system}.nixos-conf-editor
          inputs.nix-software-center.packages.${system}.nix-software-center
        ];
        baseApps = with pkgs; [
          # Web Browser
          floorp
          ungoogled-chromium
          tor-browser
          # Internet Utils
          protonvpn-gui
          wireguard-tools
          syncthing
          syncthingtray
          filezilla
          # Messaging
          signal-desktop
          # Media
          spotify
          vlc
          # Text Editing
          vscodium
        ];
        office = with pkgs; [
          # rnote
          libreoffice
          # remnote
          obsidian
          zoom-us
          # thunderbird
        ];
        social = with pkgs; [
          element-desktop
        ];
        coding = with pkgs; [
          zed-editor
          # nix
          alejandra
          deadnix
          statix
          nil
          python3
          biome
          clang
          ccls # c / c++
          # Keyboard
          vial
        ];
        keyboard = with pkgs; [
          wally-cli
          keymapp
        ];
        java = with pkgs; [
          jetbrains.idea-ultimate
          jetbrains.jcef
          maven
          temurin-bin-21
          mariadb
        ];
        video = with pkgs; [
          davinci-resolve
          # davinci-resolve-studio
        ];
        music = with pkgs; [
          # lmms
          # ardour
          reaper
          # cardinal
          # bespokesynth-with-vst2
          ## VSTS
          decent-sampler
          lsp-plugins
          samplv1
          vital
          #idk
          # zam-plugins
          # x42-plugins
          ## Compatibility
          # bottles
          wine
          yabridge
          yabridgectl
        ];
        streaming = with pkgs; [
          obs-studio
        ];
        art = with pkgs; [
          krita
          inkscape-with-extensions
        ];
        gaming = with pkgs; [
          steam
        ];
        vmware = with pkgs; [
          virtualbox
        ];
        # android = with pkgs; [
        #   android-udev-rules
        #   android-tools
        #   fwupd
        # ];
        plasma = with pkgs; [
          kdePackages.kate
          kde-gtk-config
        ];
        theming = with pkgs; [
          papirus-folders
          papirus-icon-theme
          themix-gui
          # Fonts
          nerd-fonts.jetbrains-mono
          nerd-fonts.fira-code
          inter
          rubik
          # Theming
          kde-rounded-corners
          libsForQt5.qt5.qtquickcontrols2
          libsForQt5.qt5.qtgraphicaleffects
          kdePackages.qtstyleplugin-kvantum
          inputs.kwin-effects-forceblur.packages.${pkgs.system}.default
        ];
      };
    };
  };
}
