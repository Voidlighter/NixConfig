{ pkgs, inputs, config, ... }: {
  imports = [
    ./config.nix
    ./hardware.nix
    ../options.nix
    ../common.nix
    # inputs.nixos-hardware.nixosModules.microsoft-surface-common
    inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
  ];
  config = {
    
    system.nixos.tags = [ "main-elysia" ];

    users.users.${config.my.user.name} = {
      isNormalUser = true;
      initialPassword = ""; # Set the initial password
    };

    # Sleep/suspend improvements
    powerManagement = {
      enable = true;
      powertop.enable = true;
    };

    services.logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchDocked = "ignore";
      HandleLidSwitchExternalPower = "suspend";
    };

    # I had to add this for it to compile at one point, but I'm not sure that's
    # always the case. It does use a newer kernel than it would otherwise.
    # Perhaps that means the other option, "longterm", is default.
    hardware.microsoft-surface.kernelVersion = "stable";

    # This was also done for testing's sake. Not sure if it helped.
    # ACPI sleep state (try s2idle first, then deep)
    boot.kernelParams = [
      "mem_sleep_default=s2idle" # or "deep" if s2idle doesn't work
      "nvme.noacpi=1" # Sometimes needed for NVMe SSDs
    ];
    
    # Webcam workarounds
    boot.blacklistedKernelModules = [
      # Try blacklisting these if webcam causes system issues
      # "ipu3_cio2"
      # "ipu3_imgu"
    ];
    # Alternative: Force load camera modules
    boot.kernelModules = [
      "uvcvideo" # USB Video Class driver
    ];
  };
}
