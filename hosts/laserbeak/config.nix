{
  pkgs,
  inputs,
  config,
  ...
}: {
  config = {
    my.hostname = "laserbeak";
    my.user.name = "cade";
    my.user.Name = "Cade";
    my.desktop = "cosmic";
    my.greeter = "cosmic";
    my.audio = ["rtkit" "pipewire"];

    my.app.base.enable = true;
    my.app.utils.enable = true;
    my.apps.extras = [];

    # musnix.soundcardPciId = "03:00.1";
  };
}
