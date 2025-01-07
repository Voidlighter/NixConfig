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
    ./common.nix
  ];

  home.packages = import ./../apps.nix {
    inherit inputs outputs lib config options pkgs;
    baseApps = true;
    office = true;
    plasma = true;
    hyprland = false;
    coding = true;
    art = false;
    java = false;
    video = false;
    music = true;
    gaming = false;
    streaming = false;
    android = false;
  };
}
