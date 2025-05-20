{inputs, ...}: {
  imports = [
    ./../common.nix
    ./home.nix
    ./hardware.nix
    inputs.jovian.nixosModules.default
    "${inputs.jovian}/modules"
    ../../modules/nixos/musnix.nix
  ];
  config = {
    my.hostname = "vapor";
    my.desktop = "cosmic";
    my.greeter = "";
    my.audio = ["rtkit" "pipewire"];

    my.app.base.enable = true;
    my.app.utils.enable = true;
    my.app.office.enable = true;
    my.app.school.enable = true;
    my.app.social.enable = true;
    my.app.coding.enable = true;
    my.app.keyboard.enable = true;
    my.app.gaming.enable = true;
    my.app.modeling.enable = true;
    my.app.theming.enable = true;
    my.apps.extras = [];

    jovian = {
      steam = {
        enable = true;
        autoStart = true;
        user = "cade";
        desktopSession = "plasma";
      };
      devices.steamdeck = {
        enable = true;
        autoUpdate = true;
      };
      decky-loader = {
        enable = true;
      };
    };

    musnix.soundcardPciId = "04:00.1";
    # musnix.kernel.realtime = false;
  };
}
