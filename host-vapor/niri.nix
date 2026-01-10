{ inputs, lib, me, ... }: {

  imports = [
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  config = {

    services.upower.enable = lib.mkDefault true;
    services.power-profiles-daemon.enable = lib.mkDefault true;
    services.dbus.enable = lib.mkDefault true; # For... input I think?
    programs.dconf.enable = lib.mkDefault true; # For Wayland input methods

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
