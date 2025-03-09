{...}: {
  imports = [
    ./../common.nix
    ./home.nix
    ./hardware.nix
    ../../modules/custom-pkgs/falcon.nix
  ];

  config = {
    my.hostname = "laserbeak";
    my.desktop = "cosmic";
    my.greeter = "cosmic";
    my.audio = ["rtkit" "pipewire"];

    my.app.selection = [
      "baseApps"
      "extraUtils"
      "office"
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
      # "ai"
      "work"
    ];
  };
}
