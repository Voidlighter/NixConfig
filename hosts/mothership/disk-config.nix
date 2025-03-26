# USAGE in your configuration.nix.
# Update devices to match your hardware.
# {
#   imports = [ ./disko-config.nix ];
# }
# sudo env PATH="$PATH:/nix/var/nix/profiles/system/sw/bin" nixos-install --no-channel-copy --no-root-password --flake ~/NixConfig#mothership
# sudo nix run 'github:nix-community/disko/latest#disko-install' -- --write-efi-boot-entries --flake ~/NixConfig#mothership --disk root /dev/sdc
# sudo parted /dev/sdd -- mklabel gpt
# sudo parted /dev/sdd -- mkpart primary 512MiB -8GiB
# sudo parted /dev/sdd -- mkpart primary linux-swap -8GiB 100%
# sudo parted /dev/sdd -- mkpart ESP fat32 1MiB 512MiB
# sudo parted /dev/sdd -- set 3 esp on
# sudo cryptsetup luksFormat /dev/sdd1
# sudo cryptsetup luksOpen /dev/sdd1 cryptroot
# sudo mkfs.ext4 -L NIXOS /dev/mapper/cryptroot
# sudo mkswap -L SWAP /dev/sdd2
# sudo mkfs.fat -F 32 -n BOOT /dev/sdd3
{
  disko.devices = {
    disk = {
      root = {
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };
            root = {
              size = "100%";
              content = {
                # LUKS passphrase will be prompted interactively only
                type = "luks";
                name = "cryptroot";
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                };
              };
            };
          };
        };
      };
    };
  };
}
