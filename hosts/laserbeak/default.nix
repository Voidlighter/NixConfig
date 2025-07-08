{inputs, ...}: {
  imports = [
    inputs.musnix.nixosModules.musnix
    ./home.nix
    ./hardware.nix
    ../common.nix
  ];

  config = {
  };
}
