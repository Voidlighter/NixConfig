{
  lib,
  config,
  inputs,
  pkgs,
  pkgs-stable,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../modules/apps.nix
    # ../modules/remote-build/remote-builder.nix
  ];

  options.my = {
    hostname = lib.mkOption {
      type = lib.types.str;
      default = "CadeComputer";
    };
    user.name = lib.mkOption {
      type = lib.types.str;
      default = "cade";
    };
    user.Name = lib.mkOption {
      type = lib.types.str;
      default = "Cade";
    };
    desktop = lib.mkOption {
      type = lib.types.enum ["plasma" "gnome" "cinnamon" "cosmic" ""];
      default = "plasma";
    };
    greeter = lib.mkOption {
      type = lib.types.enum ["sddm" "gdm" "lightdm" ""];
      default = "sddm";
    };
    audio = lib.mkOption {
      type = lib.types.listOf (lib.types.enum ["rtkit" "pipewire" "pulseaudio"]);
      default = ["rtkit" "pipewire"];
    };
  };

  config = {
    services.pulseaudio.enable = builtins.elem "pulseaudio" config.my.audio;
    security.rtkit.enable = builtins.elem "rtkit" config.my.audio;
    services.pipewire = {
      enable = builtins.elem "pipewire" config.my.audio;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    hardware.bluetooth.enable = true;

    users.defaultUserShell = pkgs.zsh;
    users.users.${config.my.user.name} = {
      isNormalUser = true;
      description = config.my.user.Name;
      extraGroups = ["networkmanager" "wheel" "audio"];
      # packages = with pkgs; [];
    };

    services = {
      displayManager.sddm.wayland.enable = config.my.greeter == "sddm";
      displayManager.sddm.enable = config.my.greeter == "sddm";

      desktopManager.plasma6.enable = config.my.desktop == "plasma";

      xserver.enable = true;
      # set keymap in X11
      xserver.xkb = {
        layout = "us";
        variant = "";
      };
    };

    programs = {
      neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        # vimdiffAlias = true;
      };

      nix-index.enable = true;
      nix-index.enableZshIntegration = true;
      command-not-found.enable = false;
      # nix-index-database.comma.enable = true;

      # This is where .zshrc stuff goes
      zsh = {
        enable = true;
        # autocd = true;
        autosuggestions.enable = true;
        enableCompletion = true;
        histSize = 10000;

        shellAliases = {
          ls = "eza";
        };

        # promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      };
    };

    # Enable touchpad support (enabled default in most desktopManager).
    services.libinput.enable = true;

    # Enable CUPS to print documents.
    services.printing.enable = true;

    hardware = {
      # Opengl in 24.05, graphics in 24.11
      graphics.enable = true;

      keyboard.zsa.enable = true;
    };

    services.udev.packages = with pkgs; [
      vial
      via
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    programs.mtr.enable = true;
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # Enable the OpenSSH daemon.
    services.openssh = {
      enable = true;
      ports = [22];
      settings = {
        PasswordAuthentication = true;
        AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      };
    };

    networking.networkmanager.enable = true;
    networking.hostName = config.my.hostname; # Define your hostname.
    networking.hosts = {
      "192.168.0.155" = ["veridia"];
      "192.168.0.195" = ["elysia"];
      "192.168.0.218" = ["vapor"];
    };
    # Enable networking

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [
        22
      ];
      allowedTCPPortRanges = [
        {
          # KDE Connect
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = [
        {
          # KDE Connect
          from = 1714;
          to = 1764;
        }
      ];
    };

    environment = {
      systemPackages = config.my.app.set.system;
      # sessionVariables = {
      #   # If your cursor becomes invisible
      #   # WLR_NO_HARDWARE_CURSORS = "1";
      #   # Hint electron apps to use wayland
      #   # NIXOS_OZONE_WL = "1";
      # };
    };

    # Set your time zone.
    time.timeZone = "America/Denver";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    # # XDG Portal
    # xdg.portal.enable = true;
    # xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
    # };

    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    nixpkgs.overlays = [
      (final: prev: {
        stable = pkgs-stable;
      })
    ];

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = ["nix-command" "flakes"];
    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "24.05"; # Did you read the comment=
  };
}
