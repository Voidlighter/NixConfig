{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
    ./hardware.nix
    ../options.nix
    ../common.nix
    ../../modules/custom-pkgs/falcon.nix
    inputs.nixos-hardware.nixosModules.dell-xps-13-9350
  ];

  config = {
    my.hostname = "elysia";
    my.user.name = "cade";
    my.user.Name = "Cade";
    my.greeter = "sddm";
    my.desktop = "plasma";
    my.audio = ["rtkit" "pipewire"];

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
