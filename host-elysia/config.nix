{ inputs, config, pkgs, me, ... }: {

  imports = [
    ./hardware.nix
    ../config.nix
    # inputs.nixos-hardware.nixosModules.microsoft-surface-common
    inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  config = {
    system.nixos.tags = [ "${me.hostname}-dms" ];
    my.apps = with pkgs; [
      godot_4
      blender
      # jetbrains.idea-community
    ];

    hardware.microsoft-surface.kernelVersion = "stable";

    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;

    programs.niri.enable = true;
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.swaylock = { };
    programs.dankMaterialShell.greeter = {
      enable = true;
      compositor.name = "niri";
      # optionally copies that users DMS settings (and wallpaper if set) to the greeters data directory as root before greeter starts
      configHome = "/home/${me.username}";
    };
  };
}
