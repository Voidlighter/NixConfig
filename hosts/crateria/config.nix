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
    my.desktop = "cosmic";
    my.greeter = "cosmic";
    my.audio = ["rtkit" "pipewire"];
  };
}
