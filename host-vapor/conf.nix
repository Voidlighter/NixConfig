{ inputs, config, pkgs, me, ... }: {

  imports = [
    ./hardware.nix
    ../config.nix
    inputs.dankMaterialShell.nixosModules.greeter
    inputs.musnix.nixosModules.musnix {musnix.enable = true;}
    inputs.jovian.nixosModules.default
    "${inputs.jovian}/modules"
  ];

  config = {

    system.nixos.tags = [ "${me.hostname}-dms-niri" ];

    # TODO: Replace some of these with services.
    my.apps = with pkgs; [
      # godot_4
      # davinci-resolve
      # krita
      # inkscape-with-extensions
      # blender
      # steam
      # # lmms
      # # ardour
      # reaper
      # # cardinal
      # # bespokesynth-with-vst2
      # ## VSTS
      # decent-sampler
      # lsp-plugins
      # # samplv1
      # vital
      # #idk
      # # zam-plugins
      # # x42-plugins
      # ## Compatibility
      # # bottles
      # # wine
      # # wine-staging
      # wineWowPackages.staging
      # winetricks
      # yabridge
      # yabridgectl
      qjackctl
      inputs.affinity-nix.packages.x86-linux.v3
      # calf
      # tap-plugins
      # x42-plugins
      # helm
    ];

  jovian = {
    steam = {
      enable = true;
      autoStart = true;
      user = "cade";
      desktopSession = "niri";
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
    services.joycond.enable = true;
    programs.joycond-cemuhook.enable = true;
  };
}
