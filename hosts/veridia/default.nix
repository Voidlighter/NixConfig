{inputs, ...}: {
  imports = [
    inputs.musnix.nixosModules.musnix
    ./home.nix
    ./hardware.nix
    ../common.nix
    ../../nixos/nvidia.nix
  ];

  config = {
  };
}
