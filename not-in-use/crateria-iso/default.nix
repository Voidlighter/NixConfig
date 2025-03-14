{
  modulesPath,
  config,
  ...
}: {
  imports = [
    ./../common.nix
    ./home.nix
    # ./hardware.nix
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-base.nix"
    # ../../modules/custom-pkgs/falcon.nix
  ];

  config = {
    my.hostname = "crateria";
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

    users.users.${config.my.user.name} = {
      isNormalUser = true;
      initialPassword = ""; # Set the initial password
    };

    # Enable the default live user
    users.users.nixos = {
      isNormalUser = true;
      initialPassword = "";
      extraGroups = ["wheel" "networkmanager"];
    };

    services.displayManager.autoLogin = {
      enable = true;
      user = "nixos";
    };
  };
}
