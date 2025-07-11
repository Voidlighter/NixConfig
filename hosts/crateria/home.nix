{
  config,
  osConfig,
  inputs,
  outputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../home-common.nix
  ];

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  home.file = {
    ".config/autostart/mattermost.desktop".text = ''
      [Desktop Entry]
      Name=Mattermost
      Exec=${lib.getExe pkgs.mattermost-desktop}
      Icon=${lib.getExe pkgs.mattermost-desktop}
      Terminal=false
      Type=Application
      Categories=Network;
    '';
    "install-notes/install-instructions.md" = {
      source = ../../home/install-notes-work.md;
    };
  };  
  programs.bash.shellAliases = {
    nrs = lib.mkForce "sudo nixos-rebuild switch --verbose --impure --flake ~/NixConfig#${osConfig.my.hostname}";
    nb = lib.mkForce "sudo nixos-rebuild build --verbose --impure --flake ~/NixConfig#${osConfig.my.hostname}";
    ndb = lib.mkForce "sudo nixos-rebuild dry-build --verbose --impure --flake ~/NixConfig#${osConfig.my.hostname}";
    nrb = lib.mkForce "sudo nixos-rebuild boot --verbose --impure --flake ~/NixConfig#${osConfig.my.hostname}";
  };
}
