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
      users.${config.my.user.name}.initialHashedPassword = "$y$j9T$XL3q/z11mbkwUDmPnqnRG1$vSEMObPLlEA1K/mUC818b9UOrRoUw6FatQQTlEYCGa3";
    };
  };
}
