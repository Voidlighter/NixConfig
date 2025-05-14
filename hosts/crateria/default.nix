{pkgs, inputs, config, ...}: {
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

    # TODO: I want to make my settings like this instead.
    # my.apps.base.enable = true;
    # my.apps.extraUtils.enable = true;
    # my.apps.office.enable = true;
    # my.apps.vmware.enable = true;
    # my.apps.work.enable = true;

    my.app.selection = [
      "baseApps"
      "extraUtils"
      "office"
      # "social"
      # "coding"
      # "keyboard"
      # "art"
      # "modeling"
      # "java"
      # "video"
      # "music"
      # "gaming"
      # "streaming"
      "vmware"
      # "android"
      # "plasma"
      # "theming"
      # "ai"
      "work"
    ];
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
