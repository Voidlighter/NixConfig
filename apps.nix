{ inputs, config, pkgs, lib, ... }: {
  options.my = {
    apps.extras = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [ ];
    };
    apps.sysExtras = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [ ];
    };
    app.system.enable = lib.mkEnableOption "system-wide apps" // {
      default = true;
    };
    apps.system = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        ## ESSENTIALS
        git # Can't use git without git!
        vim # Text editor

        ## Utilities

        ## - CLI -
        busybox # Brings in common CLI tools
        file # Tells filetypes
        bat # Tells file contents w/ highlighting (`cat` alternative)
        wget # File downloader
        curl # File downloader, but different
        htop # Common process viewer
        ## NOTE: May replace with bottom
        tmux # Multi-tasker
        ## NOTE: Conflict with `neovim.enable`.
        # neovim # I'll use this when I'm ready.

        fd # Simple/fast `find` alternative

        ## - GUI -
        ghostty # Terminal w/ sane defaults
        gparted # Disk formatter
        qdirstat # Graphical disk usage analyzer
        ntfs3g # Needed by gparted for ntfs
        vscodium # Text editor (FOSS VSCode)
        protonvpn-gui # My VPN of choice

        ## Browsers
        brave # Privacy-focused Chromium fork
        mullvad-browser # Privacy-focused Firefox fork
        tor-browser # Most Private Browser (Firefox fork)
      ];
    };
    app.utils.enable = lib.mkEnableOption "nifty utilities" // {
      default = true;
    };
    apps.utils = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        ripgrep
        nemo-with-extensions
        starship
        fastfetch
        bat-extras.core
        bottom
        # zoxide
        fzf

        # filezilla

        # Fonts
        nerd-fonts.jetbrains-mono
        inter
        rubik
        open-sans
      ];
    };
    app.base.enable = lib.mkEnableOption "browser, music, video player" // {
      default = true;
    };
    apps.base = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        signal-desktop
        # Media
        spotify
        vlc
      ];
    };
    app.office.enable = lib.mkEnableOption "office and email";
    apps.office = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        # rnote
        libreoffice
        obsidian
        # remnote
        # thunderbird
        # python312Packages.weasyprint
      ];
    };
    app.school.enable = lib.mkEnableOption "zoom I guess";
    apps.school = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        zoom-us
        # jetbrains.idea-community-bin
        jetbrains.idea-community
      ];
    };
    app.social.enable = lib.mkEnableOption "just element right now";
    apps.social = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [ element-desktop ];
    };
    app.coding.enable = lib.mkEnableOption "editors and dependencies";
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
    app.keyboard.enable = lib.mkEnableOption "ZSA keyboard and Vial";
    apps.keyboard = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [ wally-cli keymapp vial ];
    };
    app.java.enable = lib.mkEnableOption "Java stuff";
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
    app.video.enable = lib.mkEnableOption "video editors";
    apps.video = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs;
        [
          davinci-resolve
          # davinci-resolve-studio
        ];
    };
    # TODO: Replace some of these with services.
    app.music.enable = lib.mkEnableOption "DAWs, samplers, etc";
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
    app.streaming.enable = lib.mkEnableOption "For livestreaming";
    apps.streaming = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [ obs-studio ];
    };
    app.art.enable = lib.mkEnableOption "For art";
    apps.art = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [ krita inkscape-with-extensions ];
    };
    app.modeling.enable = lib.mkEnableOption "For modeling";
    apps.modeling = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [ blender ];
    };
    app.gaming.enable = lib.mkEnableOption "For gaming";
    apps.gaming = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [ steam ];
    };
    app.game-dev.enable = lib.mkEnableOption "For game development";
    apps.game-dev = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [ godot_4 ];
    };
    app.vmware.enable = lib.mkEnableOption "For virtual machines";
    apps.vmware = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [ qemu_kvm swtpm ];
    };
    app.android.enable = lib.mkEnableOption "For android manipulation";
    apps.android = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [ android-udev-rules android-tools fwupd ];
    };
    app.theming.enable = lib.mkEnableOption "For general theming";
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
    app.kde-theming.enable = lib.mkEnableOption "For plasma theming";
    apps.kde-theming = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        themix-gui
        # Theming
        konsave
        kde-rounded-corners
        libsForQt5.qt5.qtquickcontrols2
        libsForQt5.qt5.qtgraphicaleffects
        kdePackages.kde-gtk-config
        kdePackages.qtstyleplugin-kvantum
        kdePackages.plasma-workspace-wallpapers
        inputs.kwin-effects-forceblur.packages.${pkgs.system}.default
      ];
    };
    app.work.enable = lib.mkEnableOption "Needed for work";
    apps.work = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        mattermost-desktop
        zoom-us
        thunderbird
        # sl
      ];
    };
    # Maybe this looks wack, but this is just saying 
    # "if school is enabled, include apps for school."
    apps.home = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = lib.flatten [
        (lib.optionals config.my.app.system.enable config.my.apps.system)
        (lib.optionals config.my.app.utils.enable config.my.apps.utils)
        (lib.optionals config.my.app.base.enable config.my.apps.base)
        (lib.optionals config.my.app.office.enable config.my.apps.office)
        (lib.optionals config.my.app.school.enable config.my.apps.school)
        (lib.optionals config.my.app.social.enable config.my.apps.social)
        (lib.optionals config.my.app.coding.enable config.my.apps.coding)
        (lib.optionals config.my.app.keyboard.enable config.my.apps.keyboard)
        (lib.optionals config.my.app.java.enable config.my.apps.java)
        (lib.optionals config.my.app.video.enable config.my.apps.video)
        (lib.optionals config.my.app.music.enable config.my.apps.music)
        (lib.optionals config.my.app.streaming.enable config.my.apps.streaming)
        (lib.optionals config.my.app.art.enable config.my.apps.art)
        (lib.optionals config.my.app.modeling.enable config.my.apps.modeling)
        (lib.optionals config.my.app.gaming.enable config.my.apps.gaming)
        (lib.optionals config.my.app.game-dev.enable config.my.apps.game-dev)
        (lib.optionals config.my.app.vmware.enable config.my.apps.vmware)
        (lib.optionals config.my.app.android.enable config.my.apps.android)
        (lib.optionals config.my.app.theming.enable config.my.apps.theming)
        (lib.optionals config.my.app.kde-theming.enable
          config.my.apps.kde-theming)
        (lib.optionals config.my.app.ai.enable config.my.apps.ai)
        (lib.optionals config.my.app.tts.enable config.my.apps.tts)
        (lib.optionals config.my.app.stt.enable config.my.apps.stt)
        (lib.optionals config.my.app.llm.enable config.my.apps.llm)
        (lib.optionals config.my.app.work.enable config.my.apps.work)
        config.my.apps.extras
      ];
    };
  };
}
