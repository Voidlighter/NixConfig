{pkgs, ...}: {
  imports = [
    ./../common.nix
    ./home.nix
    ./hardware.nix
    ../../modules/custom-pkgs/falcon.nix
  ];

  config = {
    my.hostname = "crateria";
    my.desktop = "cosmic";
    my.greeter = "cosmic";
    my.audio = ["rtkit" "pipewire"];

    my.app.selection = [
      "baseApps"
      "extraUtils"
      "office"
      "work"
    ];
  };
}
