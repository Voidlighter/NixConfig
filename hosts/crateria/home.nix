{
  config,
  inputs,
  outputs,
  ...
}: {
  imports = [
  ];
  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {
        inherit inputs outputs;
        nixosConfig = config;
      };
      users.${config.my.user.name} = import ../home-common.nix;
      users.${osConfig.my.user.name}.home = {
        file = {
        ".config/autostart/mattermost.desktop".text = ''
          [Desktop Entry]
          Name=Mattermost
          Exec=mattermost-desktop
          Icon=mattermost-desktop
          Terminal=false
          Type=Application
          Categories=Network;
        '';
        };
      };
    };
  };
}
