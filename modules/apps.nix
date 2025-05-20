{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  options.my = {
    apps.extras = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [];
    };
    apps.home = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [
        (lib.optional config.my.app.system.enable config.my.apps.system)
        (lib.optional config.my.app.utils.enable config.my.apps.utils)
        (lib.optional config.my.app.base.enable config.my.apps.base)
        (lib.optional config.my.app.office.enable config.my.apps.office)
        (lib.optional config.my.app.school.enable config.my.apps.school)
        (lib.optional config.my.app.social.enable config.my.apps.social)
        (lib.optional config.my.app.coding.enable config.my.apps.coding)
        (lib.optional config.my.app.keyboard.enable config.my.apps.keyboard)
        (lib.optional config.my.app.java.enable config.my.apps.java)
        (lib.optional config.my.app.video.enable config.my.apps.video)
        (lib.optional config.my.app.music.enable config.my.apps.music)
        (lib.optional config.my.app.streaming.enable config.my.apps.streaming)
        (lib.optional config.my.app.art.enable config.my.apps.art)
        (lib.optional config.my.app.modeling.enable config.my.apps.modeling)
        (lib.optional config.my.app.gaming.enable config.my.apps.gaming)
        (lib.optional config.my.app.vmware.enable config.my.apps.vmware)
        (lib.optional config.my.app.android.enable config.my.apps.android)
        (lib.optional config.my.app.plasma.enable config.my.apps.plasma)
        (lib.optional config.my.app.theming.enable config.my.apps.theming)
        (lib.optional config.my.app.kde-theming.enable config.my.apps.kde-theming)
        (lib.optional config.my.app.ai.enable config.my.apps.ai)
        (lib.optional config.my.app.tts.enable config.my.apps.tts)
        (lib.optional config.my.app.stt.enable config.my.apps.stt)
        (lib.optional config.my.app.llm.enable config.my.apps.llm)
        (lib.optional config.my.app.work.enable config.my.apps.work)
        config.my.apps.extras
      ];
    };
    app.system = lib.mkEnableOption "system-wide apps" // {default = true;};
    apps.system = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        neovim
        # inputs.pkgsStable.legacyPackages.${pkgs.system}.vim
        bash
        blesh
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
    };
    app.utils = lib.mkEnableOption "nifty utilities" // {default = true;};
    apps.utils = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        nemo-with-extensions
        neofetch.out
        bat-extras.core
        qdirstat # Graphical disk usage analyzer
        ## Nix UI: Snowfallorg
        # inputs.nixos-conf-editor.packages.${system}.nixos-conf-editor
        # inputs.nix-software-center.packages.${system}.nix-software-center
      ];
    };
    app.base = lib.mkEnableOption "browser, music, video player" // {default = true;};
    apps.base = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
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
    };
    app.office = lib.mkEnableOption "office and email";
    apps.office = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        # rnote
        libreoffice
        obsidian
        # remnote
        thunderbird
        # python312Packages.weasyprint
      ];
    };
    app.school = lib.mkEnableOption "zoom I guess";
    apps.school = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        zoom-us
      ];
    };
    app.social = lib.mkEnableOption "just element right now";
    apps.social = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        element-desktop
      ];
    };
    app.coding = lib.mkEnableOption "editors and dependencies";
    apps.coding = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        # nix
        alejandra
        deadnix
        statix
        nil
        python3
        biome
        clang
        ccls # c / c++
      ];
    };
    app.keyboard = lib.mkEnableOption "ZSA keyboard and Vial";
    apps.keyboard = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        wally-cli
        keymapp
        vial
      ];
    };
    app.java = lib.mkEnableOption "Java stuff";
    apps.java = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        jetbrains.idea-ultimate
        jetbrains.jcef
        maven
        temurin-bin-21
        mariadb
      ];
    };
    app.video = lib.mkEnableOption "video editors";
    apps.video = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        davinci-resolve
        # davinci-resolve-studio
      ];
    };
    app.music = lib.mkEnableOption "DAWs, samplers, etc";
    apps.music = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
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
    };
    app.streaming = lib.mkEnableOption "For livestreaming";
    apps.streaming = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        obs-studio
      ];
    };
    app.art = lib.mkEnableOption "For art";
    apps.art = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        krita
        inkscape-with-extensions
      ];
    };
    app.modeling = lib.mkEnableOption "For modeling";
    apps.modeling = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        blender
      ];
    };
    app.gaming = lib.mkEnableOption "For gaming";
    apps.gaming = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        steam
      ];
    };
    app.vmware = lib.mkEnableOption "For virtual machines";
    apps.vmware = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        qemu_kvm
        swtpm
      ];
    };
    app.android = lib.mkEnableOption "For android manipulation";
    apps.android = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        android-udev-rules
        android-tools
        fwupd
      ];
    };
    app.plasma = lib.mkEnableOption "For KDE Plasma's extra tools";
    apps.plasma = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        kdePackages.kate
        kdePackages.kde-gtk-config
      ];
    };
    app.theming = lib.mkEnableOption "For general theming";
    apps.theming = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        papirus-folders
        papirus-icon-theme
        texlivePackages.josefin
        texlivePackages.jura
        league-of-moveable-type
      ];
    };
    app.kde-theming = lib.mkEnableOption "For plasma theming";
    apps.kde-theming = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        themix-gui
        # Theming
        konsave
        kde-rounded-corners
        libsForQt5.qt5.qtquickcontrols2
        libsForQt5.qt5.qtgraphicaleffects
        kdePackages.qtstyleplugin-kvantum
        kdePackages.plasma-workspace-wallpapers
        inputs.kwin-effects-forceblur.packages.${pkgs.system}.default
      ];
    };
    app.ai = lib.mkEnableOption "For all ai";
    apps.ai = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = config.my.apps.tts + config.my.apps.stt + config.my.apps.llm;
    };
    app.tts = lib.mkEnableOption "For text to speech";
    apps.tts = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        piper-tts
        wyoming-piper
      ];
    };
    stt = lib.mkEnableOption "For speech to text";
    apps.stt = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        python313Packages.faster-whisper
        wyoming-faster-whisper
      ];
    };
    app.llm = lib.mkEnableOption "For large language models";
    apps.llm = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
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
    app.work = lib.mkEnableOption "Needed for work";
    apps.work = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        mattermost-desktop
        zoom-us
      ];
    };
  };
}
