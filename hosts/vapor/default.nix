{inputs, ...}: {
  imports = [
    ./../common.nix
    ./home.nix
    ./hardware.nix
    inputs.jovian.nixosModules.default
    "${inputs.jovian}/modules"
    ../../modules/nixos/musnix.nix
  ];
  config = {
    my.hostname = "vapor";
    my.desktop = "plasma";
    my.greeter = "";
    my.audio = ["rtkit" "pipewire"];
    my.app.selection = [
      "baseApps"
      "extraUtils"
      "office"
      # "school"
      # "social"
      # "coding"
      # "keyboard"
      # "art"
      # "java"
      # "video"
      "music"
      "gaming"
      # "streaming"
      # "vmware"
      # "android"
      "plasma"
      "theming"
    ];

    jovian = {
      steam = {
        enable = true;
        autoStart = true;
        user = "cade";
        desktopSession = "plasma";
      };
      devices.steamdeck = {
        enable = true;
        autoUpdate = true;
      };
      decky-loader = {
        enable = true;
      };
    };

    musnix.soundcardPciId = "04:00.1";
    musnix.kernel.realtime = false;
  };
}
