{ inputs, ... }: {
  imports = [
    inputs.musnix.nixosModules.musnix
    ./home.nix
    ./hardware.nix
    ../common.nix
  ];

  config = { system.nixos.tags = [ "main-laserbeak" ]; };
}
