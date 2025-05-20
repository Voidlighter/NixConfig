{pkgs, ...}: {
  imports = [
    ./../common.nix
    ./home.nix
    # ./hardware.nix
    "${pkgs}/nixos/modules/installer/cd-dvd/installation-cd-base.nix"
    # ../../modules/custom-pkgs/falcon.nix
  ];

  config = {
    my.hostname = "laserbeak";
    my.desktop = "cosmic";
    my.greeter = "cosmic";
    my.audio = ["rtkit" "pipewire"];

    my.app.base.enable = true;
    my.app.utils.enable = true;
    my.app.office.enable = true;
    my.app.coding.enable = true;
    my.app.theming.enable = true;
    my.apps.extras = [];
  };
}
