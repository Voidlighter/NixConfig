{
  pkgs,
  inputs,
  config,
  ...
}: {
  config = {
    my.hostname = "elysia";
    my.user.name = "cade";
    my.user.Name = "Cade";
    my.greeter = "cosmic";
    my.desktop = "cosmic";
    my.audio = ["rtkit" "pipewire"];

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
    my.app.kde-theming.enable = false;
    my.apps.sysExtras = with pkgs; [
      libcamera
      libcamera-qcam
      v4l-utils
    ];
  };
}
