{
  lib,
  config,
  inputs,
  pkgs,
  pkgs-stable,
  ...
}: {
  imports = [
    ../modules/apps.nix
    # ../modules/custom-pkgs/floorp.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];



  config = {
    nixpkgs.overlays = [
      (final: prev: {
        stable = pkgs-stable;
      })
      (final: prev: {
        floorp = prev.floorp.overrideAttrs (old: {
          src = prev.fetchFromGitHub {
            owner = "Floorp-Projects";
            repo = "Floorp";
            fetchSubmodules = true;
            rev = "v11.27.0";
            hash = "sha256-2BSl7RHhqFAYSpshBYxuVWwLlVXdOT3xgH4tva5ShY4=";
          };
        });
      })
    ];

    nixpkgs.config.allowUnfree = true;

    nix.settings = {
      substituters = [] ++ lib.optionals (config.my.desktop == "cosmic" || config.my.greeter == "cosmic") ["https://cosmic.cachix.org/"];
      trusted-public-keys = [] ++ lib.optionals (config.my.desktop == "cosmic" || config.my.greeter == "cosmic") ["cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="];
      experimental-features = ["nix-command" "flakes"];
    };

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

    users.defaultUserShell = pkgs.bash;
    users.users.${config.my.user.name} = {
      isNormalUser = true;
      description = config.my.user.Name;
      extraGroups = ["networkmanager" "wheel" "audio" "libvirtd"];
      # packages = with pkgs; [];
    };

    programs = {

      nix-ld.enable = true;
      nix-index.enable = true;
      nix-index.enableBashIntegration = true;
      command-not-found.enable = false;
      # nix-index-database.comma.enable = true;

      # This is where .bashrc stuff goes
      bash = {
        shellAliases = {
          ls = "eza";
        };
        # programs.bash.initExtra = ''
        #   # More bash init stuff
        # '';

        # promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      };
      zoxide.enable = true;
      ssh = {
        extraConfig = ''
          Host orc
            User cadepb
            HostName ssh.rc.byu.edu
            ControlMaster auto
            ControlPath ~/.ssh/master-%r@%h:%p.socket
            ControlPersist yes
            ForwardX11 yes
            ForwardX11Trusted yes
            XAuthLocation ${lib.getExe pkgs.xorg.xauth}
            ServerAliveInterval 300
        '';
      };
      # Some programs need SUID wrappers, can be configured further or are started in user sessions.
      mtr.enable = true;
      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };

    services = {
      displayManager.sddm.wayland.enable = config.my.greeter == "sddm";
      # displayManager.sddm.enable = config.my.greeter == "sddm";
      displayManager.sddm.enable = true;
      displayManager.cosmic-greeter.enable = config.my.greeter == "cosmic";

      desktopManager.cosmic.enable = config.my.desktop == "cosmic";
      # desktopManager.plasma6.enable = config.my.desktop == "plasma";
      desktopManager.plasma6.enable = true;

      xserver.enable = true;
      # set keymap in X11
      xserver.xkb = {
        layout = "us";
        variant = "";
      };

      flatpak = {
        enable = true;
        packages = [ "us.zoom.Zoom" ];
        update.auto.enable = false;
        uninstallUnmanaged = false;
      };

      # Enable touchpad support (enabled default in most desktopManager).
      libinput.enable = true;

      # Enable CUPS to print documents.
      printing.enable = true;

      udev.extraRules = ''
        ACTION=="add", SUBSYSTEM=="usb", TEST=="power/wakeup", ATTR{power/wakeup}="enabled"
      '';

      # udev.packages = with pkgs; [
      #   vial
      #   via
      # ];

      # Enable the OpenSSH daemon.
      openssh = {
        enable = true;
      };
    };

    hardware = {
      # Opengl in 24.05, graphics in 24.11
      graphics.enable = true;

      keyboard.zsa.enable = true;
    };

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enables wireless support via wpa_supplicant.
    # I forced this off to make it work for building install-isos.
    networking.wireless.enable = lib.mkForce false;
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
    };

    environment = {
      systemPackages = config.my.apps.system;

      sessionVariables = {
        # If your cursor becomes invisible
        # WLR_NO_HARDWARE_CURSORS = "1";
        # Hint electron apps to use wayland
        # NIXOS_OZONE_WL = "1";
        # Allows COSMIC to have a clipboard manager
        COSMIC_DATA_CONTROL_ENABLED = "1";
      };
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
    xdg.portal.enable = true; # I think my zoom flatpak needs this
    # xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
    # };

    # Bootloader
    boot = {
      loader = {
        grub = {
          enable = true;
          efiSupport = true;
          useOSProber = true;
          device = "nodev";
        };
      efi.canTouchEfiVariables = true;
      };
      kernelParams = [ "mem_sleep_default=deep" ];
    };
    # boot.loader.systemd-boot.enable = lib.mkDefault true;
    # boot.loader.efi.canTouchEfiVariables = true;

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "24.05"; # Did you read the comment
  };
}
