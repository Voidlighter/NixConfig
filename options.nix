{ lib, ... }: {
  options.my = {
    desktop = lib.mkOption {
      type =
        lib.types.enum [ "plasma" "gnome" "cinnamon" "cosmic" "hyprland" "" ];
      default = "plasma"; # gnome doesn't work?
    };
    greeter = lib.mkOption {
      type =
        lib.types.enum [ "sddm" "gdm" "lightdm" "cosmic" "" ];
      default = "sddm";
    };
    audio = lib.mkOption {
      type =
        lib.types.listOf (lib.types.enum [ "rtkit" "pipewire" "pulseaudio" ]);
      default = [ "rtkit" "pipewire" ];
    };
    gpu = lib.mkOption {
      type =
        lib.types.enum [ "amd" "nvidia" "" ];
      default = "";
    };
    minimal = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
}
