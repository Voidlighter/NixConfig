{ pkgs, inputs, config, ... }: {
  imports = [
    ./config.nix
    ./hardware.nix
    ../options.nix
    ../common.nix
    ../../nixos/nvidia.nix
    inputs.musnix.nixosModules.musnix
  ];

  config = { system.nixos.tags = [ "main-veridia" ]; };
}
