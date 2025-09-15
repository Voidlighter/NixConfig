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
    my.desktop = "cosmic";
    my.greeter = "";
    my.audio = ["rtkit" "pipewire"];

    my.app.base.enable = true;
    my.app.utils.enable = true;
    my.app.office.enable = true;
    my.app.social.enable = true;
    my.app.coding.enable = true;
    my.app.keyboard.enable = true;
    my.app.gaming.enable = true;
    my.app.modeling.enable = true;
    my.app.theming.enable = true;
    my.apps.extras = [];
  };
}
