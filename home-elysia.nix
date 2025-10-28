{ inputs, config, pkgs, me, ... }: {

  imports = [
    ./home.nix
    inputs.niri.homeModules.niri
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
  ];

  config = {
    # home.file.".config/hypr".source = ./dot/hypr;
    # home.file.".config/waybar".source = ./dot/waybar;
    # home.file.".config/foot".source = ./dot/foot;

    # programs.alacritty.enable = true;
    # programs.fuzzel.enable = true;
    # programs.swaylock.enable = true;
    # programs.waybar.enable = true;
    # services.mako.enable = true;
    # services.swayidle.enable = true;
    # services.polkit-gnome.enable = true;
    programs.dankMaterialShell.enable = true;
    programs.dankMaterialShell.enableSystemd = true;

    my.apps = with pkgs; [
      godot_4
      blender
      # jetbrains.idea-community
    ];

    xdg.configFile = let
      dot-config = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dot-config";
    in {
      niri.source = "${dot-config}/niri";
      DankMaterialShell.source = "${dot-config}/DankMaterialShell";
      current-theme.source = "${dot-config}/current-theme";
      themes.source = "${dot-config}/themes";
    };
  };
}
