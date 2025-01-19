{...}: {
  imports = [
    ./../common.nix
    ./home.nix
    ./hardware.nix

    ../../modules/nixos/nvidia.nix
  ];

  config = {
    my.hostname = "veridia";
    my.desktop = "plasma";
    my.greeter = "sddm";
    my.audio = ["rtkit" "pipewire"];

    my.app-group-selection = [
      "baseApps"
      "extraUtils"
      "office"
      "social"
      "coding"
      "keyboard"
      "art"
      # "java"
      "video"
      "music"
      "gaming"
      "streaming"
      # "vmware"
      # "android"
      "plasma"
      "theming"
    ];

    musnix.soundcardPciId = "03:00.1";
  };
}
