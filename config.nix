{ inputs, config, lib, pkgs, me, ... }: {

  imports = [
    ./options.nix
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  config = {

    networking.hostName = me.hostname;

    networking.networkmanager.enable = true;
    time.timeZone = "America/Denver";
    # use UTC specifically so Windows dual-boot doesn't break things
    time.hardwareClockInLocalTime = false;
    # keep RTC in UTC
    services.timesyncd.enable = true;
    # chrony would also work

    users.users.${me.username} = {
      isNormalUser = true;
      description = me.fullname;
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [ nixfmt-classic tree ];
    };

    services.printing.enable = true;

    services.pulseaudio.enable = builtins.elem "pulseaudio" config.my.tags;
    security.rtkit.enable = builtins.elem "rtkit" config.my.tags;
    services.pipewire = {
      enable = builtins.elem "pipewire" config.my.tags;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = builtins.elem "jack" config.my.tags;
      wireplumber.enable = builtins.elem "pipewire" config.my.tags;
    };

    hardware.bluetooth.enable = true;

    environment.systemPackages = with pkgs;
      [
        kitty # Terminal emulator
        foot # Terminal emulator
        alacritty # Terminal emulator
        ghostty # Terminal w/ sane defaults
        # waybar
        # # hyprpaper # hyprland wallpaperer
        # fuzzel
        # swaylock
        # mako
        # swayidle

        ## ESSENTIALS
        git # Can't use git without git!
        vim # Text editor
        
        xwayland-satellite # Support for x apps in niri
        wl-clipboard # Wayland clipboard
        xclip # X11 clipboard
        ffmpeg # video utility

        ## Utilities

        ## - CLI -
        fastfetch # Quick way to view specs
        busybox # Brings in common CLI tools
        zip # unzip .zip files
        file # Tells filetypes
        bat # Tells file contents w/ highlighting (`cat` alternative)
        wget # File downloader
        curl # File downloader, but different
        htop # Common process viewer
        ## NOTE: May replace with bottom
        tmux # Multi-tasker
        ## NOTE: Conflict with `neovim.enable`.
        neovim # vim but easily extensible 

        fd # Simple/fast `find` alternative
        rclone # mount remote drives and cloud storage

        ## - GUI -
        gparted # Disk formatter
        qdirstat # Graphical disk usage analyzer
        ntfs3g # Needed by gparted for ntfs filesystems
        exfat # Needed by gparted for exfat filesystems
        btrfs-progs # Needed by gparted for btrfs filesystems
        cryptsetup # Needed by gparted for encrypted filesystems
        vscodium # Text editor (FOSS VSCode)
        protonvpn-gui # My VPN of choice

        ## Browsers
        brave # Privacy-focused Chromium fork
        floorp-bin # Privacy-focused Firefox fork
        mullvad-browser # More privacy-focused Firefox fork
        tor-browser # Most Private Browser (Firefox fork)
      ] ++ config.my.sys-apps ++ (if config.my.minimal == false then
        with pkgs; [
          ## Still cool packages
          ripgrep
          nemo-with-extensions
          bat-extras.core
          bottom
          fzf

          vial

          # Fonts
          nerd-fonts.jetbrains-mono
          inter
          rubik
          open-sans
          texlivePackages.josefin
          texlivePackages.jura
          league-of-moveable-type

          # Icons
          papirus-folders
          papirus-icon-theme
        ]
      else
        [ ]);

    fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

    services.xserver.enable = true; # vial needs this

    services.flatpak = {
      enable = true;
      packages = [
        "us.zoom.Zoom"
        "one.ablaze.floorp"
        "io.kapsa.drive"
        "net.pixieditor.PixiEditor"
      ];
      update.auto.enable = true;
      uninstallUnmanaged = false;
    };

    programs.nix-ld.enable = true;
    programs.nix-index.enable = true;
    programs.nix-index.enableBashIntegration = true;
    programs.command-not-found.enable = false;

    # # XDG Portal
    # I think my zoom flatpak needs this
    # Needed to use my webcam
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    programs.xwayland.enable = true;

    hardware.keyboard.zsa.enable = true;
    hardware.enableRedistributableFirmware = true;

    services.udev.packages = with pkgs; [ vial via ];

    services.openssh.enable = true;

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    ## Bootloader Setup

    boot = {
      loader = {
        limine = {
          enable = true;
          efiSupport = true;
          maxGenerations = 8;
        };
        efi.canTouchEfiVariables = true;
      };
    };

    ## Necessary Nix Settings

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    system.stateVersion = me.stateVersion;
  };
}
