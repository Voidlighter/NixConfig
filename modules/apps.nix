{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  superFilter = pkgs.callPackage ./functions/superFilter.nix {inherit lib pkgs;};
  # allElems = pkgs.callPackage ./functions/allElems.nix {inherit lib;};
in {
  options.my.app = {
    selection = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = lib.attrNames (config.app.set);
    };
    list = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = superFilter config.my.app.selection config.my.app.set;
    };
    set = lib.mkOption {
      type = lib.types.attrs;
      default = {
        system = with pkgs; [
          neovim
          # inputs.pkgsStable.legacyPackages.${pkgs.system}.vim
          bash
          zsh
          tmux
          # nushell
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
          tor-browser
          vscodium
          filezilla
          # Fonts
          nerd-fonts.jetbrains-mono
          # nerd-fonts.fira-code
          inter
          rubik
          open-sans
        ];
        extraUtils = with pkgs; [
          nemo-with-extensions
          neofetch.out
          qdirstat # Graphical disk usage analyzer
          ## Nix UI: Snowfallorg
          # inputs.nixos-conf-editor.packages.${system}.nixos-conf-editor
          # inputs.nix-software-center.packages.${system}.nix-software-center
        ];
        baseApps = with pkgs; [
          # Web Browser
          floorp
          # ungoogled-chromium
          # Internet Utils
          # protonvpn-gui
          #proton-pass
          # wireguard-tools
          # syncthing
          # syncthingtray
          # Messaging
          # signal-desktop
          # Media
          spotify
          vlc
        ];
        office = with pkgs; [
          # rnote
          libreoffice
          # remnote
          thunderbird
          # python312Packages.weasyprint
        ];
        school = with pkgs; [
          obsidian
          zoom-us
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
          # wine
          # wine-staging
          wineWowPackages.staging
          winetricks
          yabridge
          yabridgectl
          qjackctl
          calf
          tap-plugins
          x42-plugins
          helm
        ];
        streaming = with pkgs; [
          obs-studio
        ];
        art = with pkgs; [
          krita
          inkscape-with-extensions
        ];
        modeling = with pkgs; [
          blender
        ];
        gaming = with pkgs; [
          steam
        ];
        vmware = with pkgs; [
          qemu_kvm
          swtpm
        ];
        # android = with pkgs; [
        #   android-udev-rules
        #   android-tools
        #   fwupd
        # ];
        plasma = with pkgs; [
          kdePackages.kate
          kdePackages.kde-gtk-config
        ];
        theming = with pkgs; [
          papirus-folders
          papirus-icon-theme
          themix-gui
          texlivePackages.josefin
          texlivePackages.jura
          league-of-moveable-type
          # Theming
          konsave
          kde-rounded-corners
          libsForQt5.qt5.qtquickcontrols2
          libsForQt5.qt5.qtgraphicaleffects
          kdePackages.qtstyleplugin-kvantum
          kdePackages.plasma-workspace-wallpapers
          inputs.kwin-effects-forceblur.packages.${pkgs.system}.default
        ];
        ai = {
          tts = with pkgs; [
            piper-tts
            wyoming-piper
          ];
          stt = with pkgs; [
            python313Packages.faster-whisper
            wyoming-faster-whisper
          ];
          llm = with pkgs; [
            (
              if (config.my.gpu == "nvidia")
              then ollama-cuda
              else if (config.my.gpu == "amd")
              then ollama-rocm
              else ollama
            )
            open-webui
            docker
          ];
        };
        work = with pkgs; [
          mattermost-desktop
        ];
      };
    };
  };
}
