{
  pkgs,
  inputs,
  config,
  ...
}: {
  config = {
    my.hostname = "vapor";
    my.user.name = "cade";
    my.user.Name = "Cade";
    my.desktop = "plasma";
    my.greeter = "";
    my.audio = ["rtkit" "pipewire"];

    my.app.base.enable = true;
    my.app.utils.enable = true;
    my.app.office.enable = false;
    my.app.social.enable = false;
    my.app.coding.enable = false;
    my.app.keyboard.enable = true;
    my.app.gaming.enable = true;
    my.app.modeling.enable = false;
    my.app.theming.enable = false;
    my.apps.extras = [];
  };
}
