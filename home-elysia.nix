{ inputs, config, pkgs, me, ... }: {

  imports = [
    ./home.nix
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
    inputs.niri.homeModules.niri
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
      kitty # Terminal emulator
      foot # Terminal emulator
      waybar
      hyprpaper
      # jetbrains.idea-community
    ];
  };
}
