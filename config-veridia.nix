{ inputs, config, pkgs, me, ... }: {

  imports = [
    ./config.nix
    ./hardware-${me.hostname}.nix
    ./nixos/nvidia.nix
    inputs.dankMaterialShell.nixosModules.greeter
    inputs.musnix.nixosModules.musnix {musnix.enable = true;}
  ];

  config = {

    system.nixos.tags = [ "${me.hostname}-v2" ];

    # TODO: Replace some of these with services.
    my.apps = with pkgs; [
      godot_4
      davinci-resolve
      krita
      inkscape-with-extensions
      blender
      steam
      # # lmms
      # # ardour
      # reaper
      # # cardinal
      # # bespokesynth-with-vst2
      # ## VSTS
      # decent-sampler
      # lsp-plugins
      # samplv1
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
      # qjackctl
      # calf
      # tap-plugins
      # x42-plugins
      # helm
    ];

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
  };
}
