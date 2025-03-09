{inputs, ...}: {
  imports = [
    ./../common.nix
  ];
  config = {
    my.hostname = "small";
    my.desktop = "cosmic";
    my.greeter = "cosmic";
    my.audio = ["rtkit" "pulseaudio"];

    my.app.selection = [
      "baseApps"
      # "extraUtils"
      # "office"
      # "social"
      # "coding"
      # "keyboard"
      # "art"
      # "modeling"
      # "java"
      # "video"
      # "music"
      # "gaming"
      # "streaming"
      # "vmware"
      # "android"
      # "plasma"
      # "theming"
    ];
  };
}
