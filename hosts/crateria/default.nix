{...}: {
  imports = [
    ./../common.nix
    ./home.nix
  ];
  config = {
    my.hostname = "crateria";

    my.app-group-selection = [
      "baseApps"
      "extraUtils"
      "office"
      # "social"
      "coding"
      # "keyboard"
      # "art"
      # "java"
      # "video"
      # "music"
      # "gaming"
      # "streaming"
      # "vmware"
      # "android"
      # "plasma"
      # "theming"
      "work"
    ];
  };
}
