{...}: {
  imports = [
    ./../common.nix
    inputs.nixos-hardware.microsoft-surface-common
    inputs.nixos-hardware.microsoft-surface-pro-intel
    ./hardware.nix
  ];
  config = {
    my.hostname = "veridia";
    my.desktop = "plasma";
    my.greeter = "sddm";
    my.audio = ["rtkit" "pulseaudio"];

    my.app.selection = [
      "baseApps"
      "extraUtils"
      "office"
      "social"
      "coding"
      "keyboard"
      "art"
      # "java"
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
