{inputs, ...}: {
  imports = [
    ./../common.nix
    ./home.nix
    ./hardware.nix
    inputs.jovian.nixosModules.default
    "${inputs.jovian}/modules"
  ];
  config = {
    my.hostname = "vapor";
    my.desktop = "plasma";
    my.greeter = "";
    my.audio = ["rtkit" "pipewire"];
    my.app-group-selection = [
      "baseApps"
      "extraUtils"
      "office"
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
