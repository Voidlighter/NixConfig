{ inputs, config, pkgs, me, ... }: {

  imports = [
    ./hardware.nix
    ../config.nix
    # inputs.nixos-hardware.nixosModules.microsoft-surface-common
    inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
    inputs.dankMaterialShell.nixosModules.greeter
    inputs.jovian.nixosModules.default
    "${inputs.jovian}/modules"
  ];

  config = {
    system.nixos.tags = [ "${me.hostname}-dms" ];
    my.apps = with pkgs; [
      godot_4
      blender
      inputs.affinity-nix.packages.x86-linux.v3
      # jetbrains.idea-community
    ];

    jovian = {
      steam = {
        enable = true;
        autoStart = false;
        user = "cade";
        desktopSession = "niri";
      };
      decky-loader = {
        enable = true;
        # Also run `touch ~/.steam/steam/.cef-enable-remote-debugging`
        # see https://github.com/Jovian-Experiments/Jovian-NixOS/blob/development/docs/in-depth/decky-loader.md
      };
    };

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
