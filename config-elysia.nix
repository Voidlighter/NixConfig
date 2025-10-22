{ inputs, config, pkgs, me, ... }: {

  imports = [
    ./config.nix
    ./hardware-${me.hostname}.nix
    # inputs.nixos-hardware.nixosModules.microsoft-surface-common
    inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
  ];

  config = {

    system.nixos.tags = [ "elysia-v2" ];

  };
}
