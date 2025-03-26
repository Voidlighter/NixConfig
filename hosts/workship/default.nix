{
  pkgs,
  modulesPath,
  lib,
  config,
  ...
}: {
  imports = [
    ./../common.nix
    ./home.nix
    # ./hardware.nix
    ./disk-config.nix
    ../../modules/custom-pkgs/falcon.nix
    # "${modulesPath}/installer/cd-dvd/iso-image.nix"
  ];

  config = {
    my.hostname = "workship";
    my.desktop = "cosmic";
    my.greeter = "cosmic";
    my.audio = ["rtkit" "pipewire"];

    my.app.selection = [
      "baseApps"
      "extraUtils"
    ];

    environment = {
      systemPackages = lib.mkForce (config.my.app.set.system ++ []);
    };

    nixpkgs.hostPlatform = "x86_64-linux";

    users.users.${config.my.user.name} = {
      isNormalUser = true;
      initialPassword = ""; # Set the initial password
    };

    services.displayManager.autoLogin = {
      enable = true;
      user = config.my.user.name;
    };

    boot.loader.systemd-boot.enable = lib.mkForce false;
    boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
    # boot.loader.systemd-boot.graceful = true;

    # EFI booting
    # isoImage.makeEfiBootable = true;

    # USB booting
    # isoImage.makeUsbBootable = true;
  };
}
