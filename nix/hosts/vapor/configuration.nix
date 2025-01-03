{
  pkgs,
  pkgs-stable,
  lib,
  inputs,
  user,
  host,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    <jovian-nixos/modules>
  ];

  jovian = {
    # hardware = {
    #   has.amd.gpu = true;
    # };
    devices.steamdeck = {
      enable = true;
      autoUpdate = true;
    };
    decky-loader.enable = true;
    steam = {
      enable = true;
      autoStart = true;
      user = "root";
      desktopSession = "plasma";
    };
    steamos = {
      useSteamOSConfig = true;
    };
  };

  # Enable the KDE Plasma Desktop Environment.
  # services.displayManager.sddm.wayland.enable = true;
  # services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # You can see the resulting builder-strings of this NixOS-configuration with "cat /etc/nix/machines".
  # These builder-strings are used by the Nix terminal tool, e.g.
  # when calling "nix build ...".
  nix.buildMachines = [
    {
      # Will be used to call "ssh builder" to connect to the builder machine.
      # The details of the connection (user, port, url etc.)
      # are taken from your "~/.ssh/config" file.
      hostName = "veridia";
      system = "x86_64-linux";
      # Nix custom ssh-variant that avoids lots of "trusted-users" settings pain
      protocol = "ssh-ng";
      # default is 1 but may keep the builder idle in between builds
      maxJobs = 3;
      # how fast is the builder compared to your local machine
      speedFactor = 2;
      supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
      mandatoryFeatures = [];
    }
  ];
  # required, otherwise remote buildMachines above aren't used
  nix.distributedBuilds = true;
  # optional, useful when the builder has a faster internet connection than yours
  nix.settings = {
    builders-use-substitutes = true;
  };
  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  nixpkgs.overlays = [
    (final: prev: {
      stable = pkgs-stable;
    })
  ];

  environment = {
    # sessionVariables = {
    #   # If your cursor becomes invisible
    #   # WLR_NO_HARDWARE_CURSORS = "1";
    #   # Hint electron apps to use wayland
    #   # NIXOS_OZONE_WL = "1";
    # };
    systemPackages = with pkgs; [
      home-manager
      neovim
      # inputs.pkgsStable.legacyPackages.${pkgs.system}.vim
      zsh
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
      starship
      xorg.xkill

      firefox
      # (
      #   pkgs.waybar.overrideAttrs (oldAttrs: {
      #     mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
      #   })
      # )
    ];
  };

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

  # # XDG Portal
  # xdg.portal.enable = true;
  # xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  users.defaultUserShell = pkgs.zsh;

  hardware.keyboard.zsa.enable = true;

  programs = {
    # hyprland = {
    #   enable = true;
    #   # nvidiaPatches = true;
    #   xwayland.enable = true;
    # };
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

    starship.enable = true;
    starship.settings = {
      aws.disabled = true;
      gcloud.disabled = true;
      kubernetes.disabled = false;
      git_branch.style = "242";
      directory.style = "blue";
      directory.truncate_to_repo = false;
      directory.truncation_length = 8;
      python.disabled = true;
      ruby.disabled = true;
      hostname.ssh_only = false;
      hostname.style = "bold green";
    };
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
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware = {
    # Opengl in 24.05, graphics in 24.11
    graphics.enable = true;
  };

  # use the example session manager (no others are packaged yet so this is enabled by default,
  # no need to redefine it in your config for now)
  #media-session.enable = true;
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect
    ];
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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05"; # Did you read the comment?
}
