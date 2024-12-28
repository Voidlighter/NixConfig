{...}: {
  imports = [
    ./../common.nix
    # ./hardware-configuration.nix
  ];

  jovian = {
    hardware = {
      has.amd.gpu = true;
    };
    steam = {
      enable = true;
      updator.splash = "vendor";
      autostart = true;
      user = "voidlighter";
      desktop-session = "plasma";
    };
    steamos = {
      useSteamOSConfig = true;
    };
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = false;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
