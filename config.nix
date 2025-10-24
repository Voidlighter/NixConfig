{ inputs, config, lib, pkgs, me, ... }: {

  imports = [ ./options.nix ];

  config = {

    networking.hostName = me.hostname;

    networking.networkmanager.enable = true;
    time.timeZone = "America/Denver";

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
        waybar
        # hyprpaper # hyprland wallpaperer
        fuzzel
        swaylock
        mako
        swayidle

        ## ESSENTIALS
        git # Can't use git without git!
        vim # Text editor
        
        wl-clipboard # Wayland clipboard
        xclip # X11 clipboard

        ## Utilities

        ## - CLI -
        fastfetch # Quick way to view specs
        busybox # Brings in common CLI tools
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

        ## - GUI -
        gparted # Disk formatter
        qdirstat # Graphical disk usage analyzer
        ntfs3g # Needed by gparted for ntfs
        vscodium # Text editor (FOSS VSCode)
        protonvpn-gui # My VPN of choice

        ## Browsers
        brave # Privacy-focused Chromium fork
        mullvad-browser # Privacy-focused Firefox fork
        tor-browser # Most Private Browser (Firefox fork)
      ] ++ config.my.sys-apps ++ (if config.my.minimal == false then
        with pkgs; [
          ## Still cool packages
          ripgrep
          nemo-with-extensions
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
        [ ]);

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
