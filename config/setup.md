mkfs.vfat /dev/sda1
cryptsetup luksFormat /dev/sda2
cryptsetup luksOpen /dev/sda2 nixos
mkfs.ext4 /dev/mapper/nixos
mount /dev/mapper/nixos /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
nixos-generate-config --root /mnt
vim /mnt/etc/configuration.nix # optional, but you might want to make some changes
nixos-install
reboot

# create and format partitions
mkfs.vfat /dev/sda1
cryptsetup luksFormat /dev/sda2
cryptsetup luksOpen /dev/sda2 nixos
mkfs.ext4 /dev/mapper/nixos

# mount partitions in the correct paths
mount /dev/mapper/nixos /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

# install nixos
nixos-generate-config --root /mnt
nixos-install
reboot

# Generates the actual key used to authenticate on your WPA secured network
wpa_passphrase $SSID $PASSPHRASE > /etc/wpa_supplicant.conf

# Restarts WPA Supplicant, which gives us WiFi for now
systemctl restart wpa_supplicant.service
