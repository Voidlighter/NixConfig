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
    my.greeter = "sddm";
    my.desktop = "plasma";
    my.audio = ["rtkit" "pipewire"];
  };
}
