{
  pkgs,
  inputs,
  config,
  ...
}: {  
  config = {
    my.hostname = "crateria";
    my.user.name = "cade";
    my.user.Name = "Cade";
    my.desktop = "plasma";
    my.greeter = "sddm";
    my.audio = ["rtkit" "pipewire"];

    my.app.base.enable = true;
    my.app.utils.enable = true;
    my.app.office.enable = true;
    my.app.vmware.enable = true;
    my.app.work.enable = true;
    my.apps.extras = with pkgs; [obsidian rclone signal-desktop];
  };
}
