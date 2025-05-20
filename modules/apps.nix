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
    default = let
      systemPackages = if config.my.app.system or true then config.my.apps.system else [];
      utilsPackages = if config.my.app.utils or false then config.my.apps.utils else [];
      basePackages = if config.my.app.base or false then config.my.apps.base else [];
      officePackages = if config.my.app.office or false then config.my.apps.office else [];
      schoolPackages = if config.my.app.school or false then config.my.apps.school else [];
      socialPackages = if config.my.app.social or false then config.my.apps.social else [];
      codingPackages = if config.my.app.coding or false then config.my.apps.coding else [];
      keyboardPackages = if config.my.app.keyboard or false then config.my.apps.keyboard else [];
      javaPackages = if config.my.app.java or false then config.my.apps.java else [];
      videoPackages = if config.my.app.video or false then config.my.apps.video else [];
      musicPackages = if config.my.app.music or false then config.my.apps.music else [];
      streamingPackages = if config.my.app.streaming or false then config.my.apps.streaming else [];
      artPackages = if config.my.app.art or false then config.my.apps.art else [];
      modelingPackages = if config.my.app.modeling or false then config.my.apps.modeling else [];
      gamingPackages = if config.my.app.gaming or false then config.my.apps.gaming else [];
      vmwarePackages = if config.my.app.vmware or false then config.my.apps.vmware else [];
      androidPackages = if config.my.app.android or false then config.my.apps.android else [];
      plasmaPackages = if config.my.app.plasma or false then config.my.apps.plasma else [];
      themingPackages = if config.my.app.theming or false then config.my.apps.theming else [];
      kdeThemingPackages = if config.my.app.kde-theming or false then config.my.apps.kde-theming else [];
      aiPackages = if config.my.app.ai or false then config.my.apps.ai else [];
      ttsPackages = if config.my.app.tts or false then config.my.apps.tts else [];
      sttPackages = if config.my.app.stt or false then config.my.apps.stt else [];
      llmPackages = if config.my.app.llm or false then config.my.apps.llm else [];
      workPackages = if config.my.app.work or false then config.my.apps.work else [];
    in
      lib.flatten [
        systemPackages
        utilsPackages
        basePackages
        officePackages
        schoolPackages
        socialPackages
        codingPackages
        keyboardPackages
        javaPackages
        videoPackages
        musicPackages
        streamingPackages
        artPackages
        modelingPackages
        gamingPackages
        vmwarePackages
        androidPackages
        plasmaPackages
        themingPackages
        kdeThemingPackages
        aiPackages
        ttsPackages
        sttPackages
        llmPackages
        workPackages
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
      default = lib.flatten [
        config.my.apps.tts
        config.my.apps.stt
        config.my.apps.llm
      ];
    };
    app.tts = lib.mkEnableOption "For text to speech";
    apps.tts = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        piper-tts
        wyoming-piper
      ];
    };
    app.stt = lib.mkEnableOption "For speech to text";
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
