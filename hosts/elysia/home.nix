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
    };
  };
}
