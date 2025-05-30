# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/hardware/network/broadcom-43xx.nix")
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/1d3cdf42-b906-4fcf-a48c-8eda8478638f";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."crypted".device = "/dev/disk/by-uuid/6021b09e-72a6-4a1a-b406-02c6af9c291f";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/4698-1649";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  # fileSystems."/swap" = {
  #   device = "/dev/disk/by-uuid/1d3cdf42-b906-4fcf-a48c-8eda8478638f";
  #   fsType = "btrfs";
  #   options = [ "subvol=swap" "compress=no" "noatime" ];
  # };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 16 * 1024; # Size in MB
    randomEncryption.enable = true;
  }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp58s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
