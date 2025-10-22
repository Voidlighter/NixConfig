{ config, lib, pkgs, ... }: {
  options.my = {
    desktop = lib.mkOption {
      type =
        lib.types.enum [ "plasma" "gnome" "cinnamon" "cosmic" "hyprland" "" ];
      default = "plasma"; # gnome doesn't work?
    };
    greeter = lib.mkOption {
      type = lib.types.enum [ "sddm" "gdm" "lightdm" "cosmic" "" ];
      default = "sddm";
    };
    tags = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "rtkit" "pipewire" "jack"];
    };
    minimal = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    impure = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    apps = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [ ];
    };
    sys-apps = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [ ];
    };
  };
}
