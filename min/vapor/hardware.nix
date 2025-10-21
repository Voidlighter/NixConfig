{ config, lib, pkgs, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "nvme" "xhci_pci" "usb_storage" "usbhid" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/95cae04b-c2f6-4206-9809-ec96304fc95e";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."root-crypt".device =
    "/dev/disk/by-uuid/8db14d9d-a58a-4bf3-9dd7-a67747992964";
  boot.initrd.luks.devices."swap-crypt".device =
    "/dev/disk/by-uuid/58c24777-18f5-4e50-a8f6-7d9a7741b4df";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/DC29-FA99";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices = [{ device = "/dev/mapper/swap-crypt"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
