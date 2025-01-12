# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  pkgs-stable,
  lib,
  inputs,
  user,
  host,
  options,
  config,
  ...
}: {
  imports = [
    # ../modules/remote-build/remote-builder.nix
  ];

  options.my = {
    desktop = lib.mkOption {
      type = lib.types.enum ["plasma" "gnome" "cinnamon" "cosmic"];
      default = "plasma";
    };
    greeter = lib.mkOption {
      type = lib.types.enum ["sddm" "gdm" "lightdm"];
      default = "sddm";
    };
    added-system-packages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
    };
    apps = lib.mkOption {
      type = lib.types.attrs;
      default =
        lib.attrsets.getAttrs [
          "system"
          "extraUtils"
          "baseApps"
          "office"
          "social"
          "coding"
          "keyboard"
          "art"
          # "java"
          # "video"
          # "music"
          # "gaming"
          # "streaming"
          # "vmware"
          # "android"
          "plasma"
          "theming"
        ]
        import
        ../apps.nix;
    };
  };

  config = {
    networking.hostName = "${host}"; # Define your hostname.
    networking.hosts = {
      "192.168.0.155" = ["veridia"];
      "192.168.0.195" = ["elysia"];
      "192.168.0.218" = ["vapor"];
    };
    hardware.bluetooth.enable = true;

    users.users.${user.name} = {
      isNormalUser = true;
      description = "${user.Name}";
      extraGroups = ["networkmanager" "wheel"];
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

    users.defaultUserShell = pkgs.zsh;

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

        promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
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

    # Enable networking
    networking.networkmanager.enable = true;

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
      sessionVariables = {
        # If your cursor becomes invisible
        WLR_NO_HARDWARE_CURSORS = "1";
        # Hint electron apps to use wayland
        NIXOS_OZONE_WL = "1";
      };
      systemPackages = config.my.apps.system;
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
