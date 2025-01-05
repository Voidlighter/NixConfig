{
  lib,
  options,
  config,
  ...
}: {
  options = {
    remote-host = lib.mkOption {
      type = lib.type.str;
      default = "veridia";
    };
  };
  config = {
    # You can see the resulting builder-strings of this NixOS-configuration with "cat /etc/nix/machines".
    # These builder-strings are used by the Nix terminal tool, e.g.
    # when calling "nix build ...".
    nix.buildMachines = [
      {
        # Will be used to call "ssh builder" to connect to the builder machine.
        # The details of the connection (user, port, url etc.)
        # are taken from your "~/.ssh/config" file.
        hostName = "veridia";
        system = "x86_64-linux";
        # Nix custom ssh-variant that avoids lots of "trusted-users" settings pain
        protocol = "ssh-ng";
        # default is 1 but may keep the builder idle in between builds
        maxJobs = 3;
        # how fast is the builder compared to your local machine
        speedFactor = 2;
        supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
        mandatoryFeatures = [];
      }
    ];
    # required, otherwise remote buildMachines above aren't used
    nix.distributedBuilds = true;
    # optional, useful when the builder has a faster internet connection than yours
    nix.settings = {
      builders-use-substitutes = true;
    };
  };
}
