{ inputs, config, pkgs, me, ... }: 
{

  imports = [
    ../home.nix
    # ./niri-hm.nix
    ./hypr-hm.nix
    inputs.eden.homeModules.default
  ];

  config = {
    my.apps = with pkgs; [
      kitty
      retroarch-full
      steam-rom-manager
      cemu
      # joycond-cemuhook
      godot_4
      blender
      ndstool
      ranger
      vlc
      mpv
      # jetbrains.idea-community
      # wineWow64Packages.full
      # mangohud winetricks gamescope gamemode umu-launcher
      # proton-ge-bin
    ];
    programs.eden = {
      enable = true;
    };
    # programs.obs-studio.enable = true;
    # programs.obs-studio.package = pkgs.obs-studio.override {cudaSupport = true;}; 
    # programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [
    #   #  Obs-studio plugin that allows you to screen capture on wlroots based 
    #   # wayland compositors
    #   wlrobs
    #   # droidcam-obs
    #   obs-shaderfilter
    #   obs-source-clone
    #   # # obs-color-monitor
    #   # # obs-source-record
    #   obs-advanced-masks
    #   obs-scale-to-sound # scales source to sound levels
    #   obs-command-source # executes commands when scene is switched
    #   obs-source-switcher # one source that chooses between other sources
    #   obs-move-transition # move sources for transitions and more
    #   obs-aitum-multistream
    #   # # obs-vertical-canvas
    #   (pkgs.callPackage ../pkgs/obs-vertical-canvas.nix {
    #     qtbase = pkgs.qt6Packages.qtbase;
    #   })
    #   obs-backgroundremoval
    #   obs-stroke-glow-shadow
    #   obs-composite-blur
    #   obs-livesplit-one
    #   obs-mute-filter
    #   advanced-scene-switcher
    #   obs-markdown # markdown text source plugin
    #   obs-text-pthread # rich text source plugin
    #   # obs-transition-table # adds transition table to tools menu?
    # ];

    programs.lutris = {
      enable = true;
      winePackages = [ pkgs.wineWow64Packages.full ];
      extraPackages = with pkgs; [mangohud winetricks gamescope gamemode umu-launcher];
      protonPackages = [ pkgs.proton-ge-bin ];
    };

    xdg.configFile = let
      global-config = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/config";
      local-config = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/host-vapor/config";
    in {
      nvim.source = "${global-config}/nvim";
      nvim.force = true;
      current-theme.source = "${local-config}/current-theme";
      current-theme.force = true;
      themes.source = "${local-config}/themes";
      themes.force = true;
    };
  };
}
