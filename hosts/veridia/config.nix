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
    my.greeter = "cosmic";
    my.desktop = "cosmic";
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
    my.app.music.enable = true;
    my.app.modeling.enable = true;
    my.app.game-dev.enable = true;
    my.app.ai.enable = false;
    my.apps.extras = with pkgs; [
      wezterm
      muse
      musescore
    ];
    my.apps.sysExtras = with pkgs; [
      piper
    ];

    services.ratbagd.enable = true;

    # musnix.soundcardPciId = "03:00.1";
  };
}
