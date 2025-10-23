{ inputs, config, pkgs, me, ... }: {

  imports = [
    ./config.nix
    ./hardware-${me.hostname}.nix
    # inputs.nixos-hardware.nixosModules.microsoft-surface-common
    inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
  ];

  config = {
    system.nixos.tags = [ "${me.hostname}-hyprland" ];
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

    services.getty.autologinUser = "cade";
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
