{ config, pkgs, me, ... }: {

  imports = [ 
    ./hardware-${me.hostname}.nix
  ];

  config = {

    system.stateVersion = "25.05";
    system.nixos.tags = [ "veridia-v2" ];
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    # Bootloader
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
      # kernelParams = ["mem_sleep_default=deep"];
      # kernelPackages = lib.mkForce pkgs.linuxPackages;
    };
    # boot.loader.systemd-boot.enable = true;
    # boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = me.hostname;

    networking.networkmanager.enable = true;
    time.timeZone = "America/Denver";

    # Enable the X11 windowing system.
    # You can disable this if you're only using the Wayland session.
    services.xserver.enable = true;

    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${me.username} = {
      isNormalUser = true;
      description = me.fullname;
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [ nixfmt-classic ];
    };

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    programs.firefox.enable = true;

    # Allow unfree packages

    environment.systemPackages = with pkgs; [
      vim
      wget
      git
      busybox
      mullvad-browser
      tor-browser
      protonvpn-gui
      vscodium
      nixfmt-classic
    ];

    fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];
  };
}
