{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
    ./config.nix
    ./hardware.nix
    ../options.nix
    ../common.nix
    # inputs.nixos-hardware.nixosModules.microsoft-surface-common
    inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
  ];
  config = {
    users.users.${config.my.user.name} = {
      isNormalUser = true;
      initialPassword = ""; # Set the initial password
    };
  };
}
