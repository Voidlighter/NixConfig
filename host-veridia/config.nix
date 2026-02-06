{ inputs, config, pkgs, me, ... }: {

  imports = [
    ./hardware.nix
    ../config.nix
    ../system-modules/nvidia.nix
    inputs.dankMaterialShell.nixosModules.greeter
    inputs.musnix.nixosModules.musnix {musnix.enable = true;}
    inputs.jovian.nixosModules.default
    "${inputs.jovian}/modules"
  ];

  config = {

    system.nixos.tags = [ "${me.hostname}-v2" ];

    # TODO: Replace some of these with services.
    my.sys-apps = with pkgs; [
      steam
      qjackctl
    ];

    jovian = {
      steam = {
        enable = true;
        autoStart = false;
        user = "cade";
        desktopSession = "niri";
      };
      devices.steamdeck = {
        enable = false;
      };
      decky-loader = {
        enable = true;
        # Also run `touch ~/.steam/steam/.cef-enable-remote-debugging`
        # see https://github.com/Jovian-Experiments/Jovian-NixOS/blob/development/docs/in-depth/decky-loader.md
      };
    };
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
    services.hardware.openrgb.enable = true;

    programs.niri.enable = true;
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.swaylock = { };
    programs.dankMaterialShell.greeter = {
      enable = true;
      compositor.name = "niri";
      configHome =
        "/home/${me.username}"; # optionally copyies that users DMS settings (and wallpaper if set) to the greeters data directory as root before greeter starts
    };
  };
}
