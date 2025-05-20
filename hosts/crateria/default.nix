{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
    ./../common.nix
    ./home.nix
    ./hardware.nix
    ../../modules/custom-pkgs/falcon.nix
    # inputs.disko.nixosModules.disko
    # ./disk-config.nix
  ];

  config = {
    my.hostname = "crateria";
    my.user.name = "cade";
    my.user.Name = "Cade";
    my.desktop = "plasma";
    my.greeter = "sddm";
    my.audio = ["rtkit" "pipewire"];

    my.app.base.enable = true;
    my.app.utils.enable = true;
    my.app.office.enable = true;
    my.app.vmware.enable = true;
    my.app.work.enable = true;
    my.apps.extras = [];

    users.users.${config.my.user.name} = {
      isNormalUser = true;
      initialPassword = ""; # Set the initial password
    };
    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = ["cade"];
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
  };
}
