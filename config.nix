{ inputs, config, lib, pkgs, me, ... }: {

  imports = [ ./options.nix ];

  config = {

    networking.hostName = me.hostname;

    networking.networkmanager.enable = true;
    time.timeZone = "America/Denver";

    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    # Enable the X11 windowing system.
    # You can disable this if you're only using the Wayland session.
    services.xserver.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${me.username} = {
      isNormalUser = true;
      description = me.fullname;
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [ nixfmt-classic ];
    };

    services.xserver.xkb = {
      layout = "us";
      variant = "";
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

    # Allow unfree packages

    environment.systemPackages = with pkgs;
      [
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
      ] ++ (if config.my.minimal == false then
        with pkgs; [
          ## Still cool packages
          ripgrep
          nemo-with-extensions
          starship
          fastfetch
          bat-extras.core
          bottom
          fzf

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
        [ ]) ++ config.my.sys-apps;

    fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

    ## Bootloader Setup

    boot = {
      loader = {
        grub = {
          enable = true;
          efiSupport = true;
          useOSProber = true;
          device = "nodev";
          configurationLimit = 10;
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
