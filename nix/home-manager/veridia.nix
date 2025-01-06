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

  home.packages = import ./../apps.nix {
    inherit inputs outputs lib config options pkgs;
    art = true;
    coding = true;
    java = true;
    video = true;
    music = true;
    gaming = true;
    streaming = true;
    android = false;
  };
}
