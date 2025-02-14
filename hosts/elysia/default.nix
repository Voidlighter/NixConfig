{inputs, ...}: {
  imports = [
    ./../common.nix
    # inputs.nixos-hardware.nixosModules.microsoft-surface-common
    inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
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
      "modeling"
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
