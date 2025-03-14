{
  config,
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.musnix.nixosModules.musnix
    # ../wine/native-access.nix
    # {wrapWine = pkgs.callPackage ../wine/wrapWine.nix {};}
  ];

  config = {
    musnix = {
      enable = true;
      # soundcardPciId = "03:00.1";
      rtcqs.enable = true;
      rtirq.enable = true;
    };
  };
}
