{
  pkgs,
  host,
  ...
}: {
  nix.distributedBuilds = true;
  nix.settings.builders-use-substitutes = true;

  nix.buildMachines = [
    {
      hostName = "${host}";
      sshUser = "remotebuild";
      sshKey = "/root/.ssh/remotebuild";
      system = pkgs.stdenv.hostPlatform.system;
      supportedFeatures = ["nixos-test" "big-parallel" "kvm"];
    }
  ];
}
