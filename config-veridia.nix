{ inputs, config, pkgs, me, ... }: {

  imports = [ ./config.nix ./hardware-${me.hostname}.nix ];

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

    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    # Enable the X11 windowing system.
    # You can disable this if you're only using the Wayland session.
    services.xserver.enable = true;

    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };
}
