{
  pkgs,
  modulesPath,
  lib,
  config,
  ...
}: {
  imports = [
    ./../common.nix
    ./home.nix
    ./disk-config.nix
    # "${modulesPath}/installer/cd-dvd/installation-cd-graphical-base.nix"
    "${modulesPath}/installer/cd-dvd/iso-image.nix"
  ];

  config = {
    my.hostname = "mothership";
    my.desktop = "cosmic";
    my.greeter = "cosmic";
    my.audio = ["rtkit" "pipewire"];

    my.app.selection = [
      "baseApps"
      "extraUtils"
    ];

    environment = {
      systemPackages = lib.mkForce (config.my.app.set.system ++ []);
      # lib.mkForce (config.my.app.set.system ++ [(
      #   writeShellScriptBin "nix_installer"
      #   ''
      #     #!/usr/bin/env bash
      #     set -euo pipefail
      #     gsettings set org.gnome.desktop.session idle-delay 0
      #     gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'

      #     if [ "$(id -u)" -eq 0 ]; then
      #   	  echo "ERROR! $(basename "$0") should be run as a regular user"
      #   	  exit 1
      #     fi

      #     if [ ! -d "$HOME/NixConfig/.git" ]; then
      #   	  git clone https://gitlab.com/hmajid2301/NixConfig.git "$HOME/NixConfig"
      #     fi

      #     TARGET_HOST=$(ls -1 ~/NixConfig/hosts/*/configuration.nix | cut -d'/' -f6 | grep -v iso | gum choose)

      #     if [ ! -e "$HOME/NixConfig/hosts/$TARGET_HOST/disks.nix" ]; then
      #   	  echo "ERROR! $(basename "$0") could not find the required $HOME/NixConfig/hosts/$TARGET_HOST/disks.nix"
      #   	  exit 1
      #     fi

      #     gum confirm  --default=false \
      #     "🔥 🔥 🔥 WARNING!!!! This will ERASE ALL DATA on the disk $TARGET_HOST. Are you sure you want to continue?"

      #     echo "Partitioning Disks"
      #     sudo nix run github:nix-community/disko \
      #     --extra-experimental-features "nix-command flakes" \
      #     --no-write-lock-file \
      #     -- \
      #     --mode zap_create_mount \
      #     "$HOME/NixConfig/hosts/$TARGET_HOST/disks.nix"

      #     sudo nixos-install --flake "$HOME/NixConfig#$TARGET_HOST"
      #   ''
      # )]);
    };

    nixpkgs.hostPlatform = "x86_64-linux";

    users.users.${config.my.user.name} = {
      isNormalUser = true;
      initialPassword = ""; # Set the initial password
    };

    # Enable the default live user
    users.users.nixos = {
      isNormalUser = true;
      initialPassword = "";
      extraGroups = ["wheel" "networkmanager"];
    };

    services.displayManager.autoLogin = {
      enable = true;
      user = "nixos";
    };

    # EFI booting
    # isoImage.makeEfiBootable = true;

    # USB booting
    # isoImage.makeUsbBootable = true;
  };
}
