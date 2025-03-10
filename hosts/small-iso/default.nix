{
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    ./../common.nix
    ./home.nix
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  config = {
    my.hostname = "small";
    my.desktop = "cosmic";
    my.greeter = "cosmic";
    my.audio = ["rtkit" "pipewire"];

    my.app.selection = [
      "baseApps"
      "extraUtils"
    ];

    nixpkgs.hostPlatform = "x86_64-linux";
  };
}
