{ inputs, config, pkgs, me, ... }: {

  imports = [
    ../home.nix
    inputs.niri.homeModules.niri
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
  ];

  config = {
    programs.dankMaterialShell.enable = true;
    programs.dankMaterialShell.enableSystemd = true;

    my.apps = with pkgs; [
      godot_4
      blender
      aseprite
      pinta
      # jetbrains.idea-community
    ];

    xdg.configFile = let
      dot-config = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dot-config";
    in {
      niri.source = "${dot-config}/niri";
      niri.force = true;
      DankMaterialShell.source = "${dot-config}/DankMaterialShell";
      DankMaterialShell.force = true;
      nvim.source = "${dot-config}/nvim";
      nvim.force = true;
      current-theme.source = "${dot-config}/current-theme";
      current-theme.force = true;
      themes.source = "${dot-config}/themes";
      themes.force = true;
    };
  };
}
