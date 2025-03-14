# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    ../../modules/home-manager/zsh.nix
    ../../modules/home-manager/starship.nix
    ../../modules/apps.nix
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    # nix-index-database.hmModules.nix-index
    inputs.plasma-manager.homeManagerModules.plasma-manager
    # inputs.musnix.nixosModules.musnix
  ];
  options.my = {
    hostname = lib.mkOption {
      type = lib.types.str;
      default = "CadeComputer";
    };
    user.name = lib.mkOption {
      type = lib.types.str;
      default = "cade";
    };
    user.Name = lib.mkOption {
      type = lib.types.str;
      default = "Cade";
    };
    desktop = lib.mkOption {
      type = lib.types.enum ["plasma" "gnome" "cinnamon" "cosmic" ""];
      default = "plasma";
    };
    greeter = lib.mkOption {
      type = lib.types.enum ["sddm" "gdm" "lightdm" "cosmic" ""];
      default = "sddm";
    };
    audio = lib.mkOption {
      type = lib.types.listOf (lib.types.enum ["rtkit" "pipewire" "pulseaudio"]);
      default = ["rtkit" "pipewire"];
    };
    gpu = lib.mkOption {
      type = lib.types.enum ["amd" "nvidia" ""];
      default = "";
    };
  };
  config = {
    my.hostname = "crateria";

    my.app.selection = [
      "baseApps"
      "extraUtils"
      "office"
      # "social"
      "coding"
      # "keyboard"
      # "art"
      # "java"
      # "video"
      # "music"
      # "gaming"
      # "streaming"
      # "vmware"
      # "android"
      # "plasma"
      # "theming"
      "work"
    ];


    nixpkgs = {
      overlays = [];
      config = {
        allowUnfree = true;
        # Workaround for https://github.com/nix-community/home-manager/issues/2942
        allowUnfreePredicate = _: true;
      };
      
    };

    home = {
      username = "cade";
      homeDirectory = "/home/cade";
      stateVersion = "23.05";
      sessionVariables = {
        EDITOR = "nvim";
      };
      file = {
      };

      packages = config.my.app.list;
    };

    # Add stuff for your user as you see fit:
    programs.neovim.enable = true;

    # Enable home-manager and git
    programs.home-manager.enable = true;
    programs.git.enable = true;

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";
  };
}
