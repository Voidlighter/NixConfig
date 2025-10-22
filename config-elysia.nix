{ inputs, config, pkgs, me, ... }: {

  imports = [
    ./config.nix
    ./hardware-${me.hostname}.nix
    # inputs.nixos-hardware.nixosModules.microsoft-surface-common
    inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
  ];

  config = {

    system.nixos.tags = [ "${me.hostname}-v2" ];
    my.apps = with pkgs; [
      godot_4
      blender
      # jetbrains.idea-community
    ];
  };
}
