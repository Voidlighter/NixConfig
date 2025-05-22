{
  osConfig,
  inputs,
  lib,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    # nix-index-database.hmModules.nix-index
    inputs.plasma-manager.homeManagerModules.plasma-manager
    ../modules/starship
    ../modules/bash
    ../modules/apps.nix
    # inputs.musnix.nixosModules.musnix
  ];

  # config = {
  # users.${osConfig.my.user.name} = {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/xml" = "${lib.getExe pkgs.floorp}";
      "text/html" = "${lib.getExe pkgs.floorp}";
      "x-scheme-handler/ftp" = "${lib.getExe pkgs.floorp}";
      "x-scheme-handler/http" = "${lib.getExe pkgs.floorp}";
      "x-scheme-handler/https" = "${lib.getExe pkgs.floorp}";
      "x-scheme-handler/chrome" = "${lib.getExe pkgs.floorp}";
      "application/xhtml+xml" = "${lib.getExe pkgs.floorp}";
      "application/x-extension-htm" = "${lib.getExe pkgs.floorp}";
      "application/x-extension-html" = "${lib.getExe pkgs.floorp}";
      "application/x-extension-shtml" = "${lib.getExe pkgs.floorp}";
      "application/x-extension-xhtml" = "${lib.getExe pkgs.floorp}";
      "application/x-extension-xht" = "${lib.getExe pkgs.floorp}";
    };
    associations.added = {
      "text/xml" = "${lib.getExe pkgs.floorp}";
      "text/html" = "${lib.getExe pkgs.floorp}";
      "x-scheme-handler/ftp" = "${lib.getExe pkgs.floorp}";
      "x-scheme-handler/http" = "${lib.getExe pkgs.floorp}";
      "x-scheme-handler/https" = "${lib.getExe pkgs.floorp}";
      "x-scheme-handler/chrome" = "${lib.getExe pkgs.floorp}";
      "application/xhtml+xml" = "${lib.getExe pkgs.floorp}";
      "application/x-extension-htm" = "${lib.getExe pkgs.floorp}";
      "application/x-extension-html" = "${lib.getExe pkgs.floorp}";
      "application/x-extension-shtml" = "${lib.getExe pkgs.floorp}";
      "application/x-extension-xhtml" = "${lib.getExe pkgs.floorp}";
      "application/x-extension-xht" = "${lib.getExe pkgs.floorp}";
    };
  };
  home = {
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    # basically don't change this. It isn't the version number
    stateVersion = "24.05";
    username = "${osConfig.my.user.name}";
    homeDirectory = "/home/${osConfig.my.user.name}";

    sessionVariables = {
      EDITOR = "${lib.getExe pkgs.neovim}";
      BROWSER = "${lib.getExe pkgs.floorp}";
      # TERMINAL = "${lib.getExe pkgs.kitty}";
    };
    
    packages = osConfig.my.apps.home;
    file = {
      ".config/autostart/mattermost.desktop".text = ''
        [Desktop Entry]
        Name=Mattermost
        Exec=mattermost-desktop
        Icon=mattermost-desktop
        Terminal=false
        Type=Application
        Categories=Network;
      '';

      "install-instructions.md".text = ''
        # Minimal UEFI/GPT Installation
        ```
        lsblk
        sudo fdisk /dev/diskX
        ```
        In fdisk:
            g (gpt disk label)
            n
            1 (partition number [1/128])
            2048 first sector
            +500M last sector (boot sector size)
            t
            1 (EFI System)
            n
            2
            default (fill up partition)
            default (fill up partition)
            w (write)

        # Label Partitions

        ```
        lsblk
        ```

        use those labels for the following commands:

        ```
        sudo mkfs.fat -F 32 /dev/sda1
        sudo fatlabel /dev/sda1 NIXBOOT
        sudo mkfs.ext4 /dev/sda2 -L NIXROOT
        ```

        # Create a swap file

        ```
        sudo dd if=/dev/zero of=/mnt/.swapfile bs=1024 count=2097152 # 2GB size
        sudo chmod 600 /mnt/.swapfile
        sudo mkswap /mnt/.swapfile
        sudo swapon /mnt/.swapfile
        ```

        # Create NixOS config

        ```
        sudo nixos-generate-config --root /mnt
        sudo cp /mnt/etc/nixos/hardware-configuration.nix ~/NixConfig/hosts/HOST/hardware.nix
        cd /mnt
        sudo nixos-install --flake ~/NixConfig#HOST
        passwd
        ```

        # Connect to WiFi

        ```
        nmcli connection modify "TheSSID" wifi-sec.key-mgmt wpa-eap 802-1x.eap peap 802-1x.phase2-auth mschapv2 802-1x.identity "MyName"
        nmcli --ask connection up TheSSID
        ```
      '';
    };
  };

  fonts.fontconfig.enable = true;

  programs = {
    home-manager = {
      enable = true;
      # useGlobalPkgs = true;
    };

    git = {
      enable = true;
      userName = "voidlighter";
      userEmail = "voidlighter@proton.me";
      aliases = {};
    };

    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };

    nix-index.enable = true;
    nix-index.enableZshIntegration = true;
    #     nix-index-database.comma.enable = true;

    konsole = {
      enable = true;
    };
    eza = {
      enable = true;
    };

    # dconf.settings = {
    #   "org/virt-manager/virt-manager/connections" = {
    #     autoconnect = ["qemu:///system"];
    #     uris = ["qemu:///system"];
    #   };
    # };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
  # };
  #   };
  # };
}
