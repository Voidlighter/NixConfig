{...}: {
  imports = [
    ./../common.nix
  ];
  config = {
    my.hostname = "crateria";

    my.app.selection = [
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
