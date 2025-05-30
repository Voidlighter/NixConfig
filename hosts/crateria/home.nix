{
  config,
  osConfig,
  inputs,
  outputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../home-common.nix
  ];

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  home.file = {
    ".config/autostart/mattermost.desktop".text = ''
      [Desktop Entry]
      Name=Mattermost
      Exec=${lib.getExe pkgs.mattermost-desktop}
      Icon=${lib.getExe pkgs.mattermost-desktop}
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

      # Ensure Falcon is running:
      ```
      systemctl status falcon-sensor
      sudo /opt/CrowdStrike/falconctl -g --rfm-state
      ```
    '';
  };
}
