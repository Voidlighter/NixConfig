{ config, pkgs, inputs, my, ... }: {
  imports = [
    ./hardware.nix
    # inputs.nixos-hardware.nixosModules.microsoft-surface-common
    inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
  ];

  system.nixos.tags = [ "min-elysia" ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  hardware.microsoft-surface.kernelVersion = "stable";

  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      useOSProber = true;
      device = "nodev";
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "elysia"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cade = {
    isNormalUser = true;
    description = "Cade";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs;
      [
        kdePackages.kate
        #  thunderbird
      ];
  };

  system.stateVersion = "25.05"; # Don't change this. Read the docs on why
}

