{ inputs, config, pkgs, me, ... }: {

  imports = [
    ./config.nix
    ./hardware-${me.hostname}.nix
    # inputs.nixos-hardware.nixosModules.microsoft-surface-common
    inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
  ];

  config = {
    sy'stem.nixos.tags = [ "${me.hostname}-v2" ];
    my.apps = with pkgs; [
      godot_4
      blender
      # jetbrains.idea-community
    ];

    hardware.microsoft-surface.kernelVersion = "stable";

    # services.getty.autologinUser = "cade";
    # programs.hyprland = {
      
  };
}
