{ inputs, config, pkgs, me, ... }: 
{

  imports = [
    inputs.niri.homeModules.niri
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
  ];

  config = {
    programs.dankMaterialShell = {
      enable = true;
      systemd.enable = true;              # Systemd service for auto-start
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

    xdg.configFile = let
      global-config = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/config";
      local-config = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/host-vapor/config";
    in {
      niri.source = "${global-config}/niri";
      niri.force = true;
      dms.source = "${global-config}/DankMaterialShell";
      dms.force = true;
    };
  };
}
