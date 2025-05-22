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

    my.app.base.enable = true;
    my.app.utils.enable = true;
    my.app.office.enable = true;
    my.app.school.enable = true;
    my.app.social.enable = true;
    my.app.coding.enable = true;
    my.app.game-dev.enable = true;
    my.app.keyboard.enable = true;
    my.app.art.enable = true;
    my.app.modeling.enable = true;
    my.app.plasma.enable = true;
    my.app.theming.enable = true;
    my.app.kde-theming.enable = true;
    my.apps.extras = [];
  };
}
