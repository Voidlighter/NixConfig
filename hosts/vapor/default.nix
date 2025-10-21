{inputs, ...}: {
  imports = [
    ./config.nix
    ./hardware.nix
    ../options.nix
    ../common.nix
    ../../nixos/musnix.nix
    inputs.jovian.nixosModules.default
    "${inputs.jovian}/modules"
  ];
  config = {
    system.nixos.tags = ["main-jovian-vapor"];

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
    services.logrotate.checkConfig = false;
    musnix.soundcardPciId = "04:00.1";
    # musnix.kernel.realtime = false;
  };
}
