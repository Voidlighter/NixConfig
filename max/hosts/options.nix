{ lib, ... }: {
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
      type = lib.types.enum [ "plasma" "gnome" "cinnamon" "cosmic" "" ];
      default = "plasma"; # gnome doesn't work?
    };
    greeter = lib.mkOption {
      type = lib.types.enum [ "sddm" "gdm" "lightdm" "cosmic" "" ];
      default = "sddm";
    };
    audio = lib.mkOption {
      type =
        lib.types.listOf (lib.types.enum [ "rtkit" "pipewire" "pulseaudio" ]);
      default = [ "rtkit" "pipewire" ];
    };
    gpu = lib.mkOption {
      type = lib.types.enum [ "amd" "nvidia" "" ];
      default = "";
    };
  };
}
