{...}: {
  imports = [
    ./../common.nix
    ./home.nix
    ./hardware.nix
    ../../modules/nixos/musnix.nix
    ../../modules/nixos/nvidia.nix
  ];

  config = {
    my.hostname = "veridia";
    my.desktop = "cosmic";
    my.greeter = "cosmic";
    my.audio = ["rtkit" "pipewire"];
    my.gpu = "nvidia";

    my.app.selection = [
      "baseApps"
      "extraUtils"
      "office"
      "social"
      "coding"
      "keyboard"
      "art"
      "modeling"
      # "java"
      "video"
      "music"
      "gaming"
      "streaming"
      # "vmware"
      # "android"
      "plasma"
      "theming"
      "ai"
    ];

    musnix.soundcardPciId = "03:00.1";
    musnix.kernel.realtime = true;
  };
}
