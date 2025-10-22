{ inputs, config, pkgs, me, ... }: {

  imports = [
    ./config.nix
    ./hardware-${me.hostname}.nix
  ];

  config = {

    system.nixos.tags = [ "veridia-v2" ];

  };
}
