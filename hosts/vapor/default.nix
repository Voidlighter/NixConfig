{inputs, ...}: {
  imports = [
    ./home.nix
    ./hardware.nix
    ../common.nix
    ../../nixos/musnix.nix
    inputs.jovian.nixosModules.default
    "${inputs.jovian}/modules"
  ];
  config = {

    jovian = {
      steam = {
        enable = true;
        autoStart = true;
        user = "cade";
        desktopSession = "plasma";
      };
      devices.steamdeck = {
        enable = true;
        autoUpdate = true;
      };
      decky-loader = {
        enable = true;
      };
    };

    musnix.soundcardPciId = "04:00.1";
    # musnix.kernel.realtime = false;
  };
}
