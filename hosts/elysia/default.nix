{...}: {
  imports = [
    ./../common.nix
    ./hardware.nix
  ];
  config = {
    my.hostname = "veridia";
    my.desktop = "plasma";
    my.greeter = "sddm";
    my.audio = ["rtkit" "pulseaudio"];

    my.app-group-selection = [
      "baseApps"
      "extraUtils"
      "office"
      "social"
      "coding"
      "keyboard"
      "art"
      "java"
      # "video"
      # "music"
      # "gaming"
      # "streaming"
      # "vmware"
      # "android"
      "plasma"
      "theming"
    ];
  };
}
