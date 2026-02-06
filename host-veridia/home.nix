{ inputs, config, pkgs, ... }: 
{

  imports = [
    ../home.nix
    inputs.niri.homeModules.niri
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
  ];

  config = {
    programs.dankMaterialShell = {
      enable = true;
      enableSystemd = true;              # Systemd service for auto-start
      # enableSystemMonitoring = true;     # System monitoring widgets (dgop)
      # enableClipboard = true;            # Clipboard history manager
      # enableVPN = true;                  # VPN management widget
      # enableBrightnessControl = true;    # Backlight/brightness controls
      # enableColorPicker = true;          # Color picker tool
      # enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
      # enableAudioWavelength = true;      # Audio visualizer (cava)
      # enableCalendarEvents = true;       # Calendar integration (khal)
      # enableSystemSound = true;          # System sound effects
      # niri = {
      #   enableKeybinds = true;   # Automatic keybinding configuration
      #   enableSpawn = true;      # Auto-start DMS with niri
      # };
      # default.settings = {
      #   theme = "dark";
      #   dynamicTheming = true;
      #   # Add any other settings here
      # };
    };
    # TODO: Replace some of these with services.
    my.apps = with pkgs; [
      godot_4
      blender
      davinci-resolve
      # inkscape-with-extensions
      # # # lmms
      # # # ardour
      # reaper
      # # # cardinal
      # # # bespokesynth-with-vst2
      # # ## VSTS
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
      # calf
      # tap-plugins
      # x42-plugins
      # helm
      # jetbrains.idea-community
      wineWow64Packages.full
      mangohud winetricks gamescope gamemode umu-launcher
    ];
    programs.obs-studio.enable = true;
    programs.obs-studio.package = pkgs.obs-studio.override {cudaSupport = true;}; 
    programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [
      #  Obs-studio plugin that allows you to screen capture on wlroots based 
      # wayland compositors
      wlrobs
      # droidcam-obs
      obs-shaderfilter
      obs-source-clone
      # # obs-color-monitor
      # # obs-source-record
      obs-advanced-masks
      obs-scale-to-sound # scales source to sound levels
      obs-command-source # executes commands when scene is switched
      obs-source-switcher # one source that chooses between other sources
      obs-move-transition # move sources for transitions and more
      obs-aitum-multistream
      # # obs-vertical-canvas
      (pkgs.callPackage ../pkgs/obs-vertical-canvas.nix {
        qtbase = pkgs.qt6Packages.qtbase;
      })
      obs-backgroundremoval
      obs-stroke-glow-shadow
      obs-composite-blur
      obs-livesplit-one
      obs-mute-filter
      advanced-scene-switcher
      obs-markdown # markdown text source plugin
      obs-text-pthread # rich text source plugin
      # obs-transition-table # adds transition table to tools menu?
    ];

    programs.freetube.enable = true;
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
      themes.source = "${global-config}/themes";
      themes.force = true;
    };
  };
}
