{
  pkgs,
  inputs,
  config,
  ...
}: {  
  config = {
    my.hostname = "veridia";
    my.user.name = "cade";
    my.user.Name = "Cade";
    my.desktop = "cosmic";
    my.greeter = "cosmic";
    my.audio = ["rtkit" "pipewire"];
    my.gpu = "nvidia";

    my.app.base.enable = true;
    my.app.utils.enable = true;
    my.app.office.enable = true;
    my.app.school.enable = true;
    my.app.social.enable = true;
    my.app.coding.enable = true;
    my.app.keyboard.enable = true;
    my.app.art.enable = true;
    my.app.modeling.enable = true;
    my.app.plasma.enable = true;
    my.app.theming.enable = true;
    my.app.kde-theming.enable = true;
    my.app.ai.enable = true;
    my.apps.extras = [];

    # musnix.soundcardPciId = "03:00.1";
  };
}
