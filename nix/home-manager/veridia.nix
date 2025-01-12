# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  lib,
  inputs,
  outputs,
  config,
  options,
  pkgs,
  user,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    ./common.nix
  ];

  config.my.apps =
    lib.attrsets.getAttrs [
      "system"
      "extraUtils"
      "baseApps"
      "office"
      "social"
      "coding"
      "keyboard"
      "art"
      "java"
      "video"
      "music"
      "gaming"
      "streaming"
      # "vmware"
      # "android"
      "plasma"
      "theming"
    ]
    import
    ./../apps.nix;

  home.packages = lib.attrsets.attrsValues config.my.apps;
}
