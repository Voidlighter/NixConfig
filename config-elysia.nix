{ inputs, config, pkgs, me, ... }: {

  imports = [
    ./config.nix
    ./hardware-${me.hostname}.nix
    # inputs.nixos-hardware.nixosModules.microsoft-surface-common
    inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
  ];

  config = {
    system.nixos.tags = [ "${me.hostname}-niri" ];
    my.apps = with pkgs; [
      godot_4
      blender
      kitty # Terminal emulator
      foot # Terminal emulator
      waybar
      hyprpaper
      # jetbrains.idea-community
    ];

    hardware.microsoft-surface.kernelVersion = "stable";

    # Enable the KDE Plasma Desktop Environment.
    # services.displayManager.sddm.enable = true;
    # services.desktopManager.plasma6.enable = true;

    # # Enable the X11 windowing system.
    # # You can disable this if you're only using the Wayland session.
    # services.xserver.enable = true;

    # services.xserver.xkb = {
    #   layout = "us";
    #   variant = "";
    # };

    services.getty.autologinUser = "cade";
    # programs.hyprland = {
    #   enable = true;
    #   xwayland.enable = true;
    # };
    programs.niri.enable = true;
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.swaylock = {};
    programs.waybar.enable = true;
  };
}
