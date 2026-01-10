{ inputs, pkgs, me, ... }: {

  imports = [
    ./hardware.nix
    ../config.nix
    # ./niri.nix
    ./hypr.nix
    inputs.musnix.nixosModules.musnix {musnix.enable = true;}
    inputs.jovian.nixosModules.default
    "${inputs.jovian}/modules"
  ];

  config = {

    system.nixos.tags = [ "${me.hostname}-hypr-noct" ];

    my.sys-apps = with pkgs; [
      qjackctl
      inputs.affinity-nix.packages.${pkgs.system}.v3
      wvkbd
      clickclack
      hyprpaper
    ];

    jovian = {
      steam = {
        enable = true;
        autoStart = true;
        user = "cade";
        desktopSession = "hyprland";
      };
      devices.steamdeck = {
        enable = true;
      };
      decky-loader = {
        enable = true;
        # Also run `touch ~/.steam/steam/.cef-enable-remote-debugging`
        # Or change it in the steam deck settings page
        # see https://github.com/Jovian-Experiments/Jovian-NixOS/blob/development/docs/in-depth/decky-loader.md
      };
    };
    programs.java.enable = true;
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
    services.dbus.enable = true; # For... input I think?
    programs.dconf.enable = true; # For Wayland input methods

    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.swaylock = { };
    services.joycond.enable = true;
    programs.joycond-cemuhook.enable = true;
  };
}
