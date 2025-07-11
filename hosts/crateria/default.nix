{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
    ./hardware.nix
    ./config.nix
    ../options.nix
    ../common.nix
    ../../nixos/falcon.nix
    inputs.nixos-hardware.nixosModules.dell-xps-13-9350
  ];

  config = {
    users.users.${config.my.user.name} = {
      isNormalUser = true;
      initialPassword = ""; # Set the initial password
    };
    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = [config.my.user.name];
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
  };
}
