{
  users.users.remotebuild = {
    isNormalUser = true;
    createHome = false;
    group = "remotebuild";

    openssh.authorizedKeys.keyFiles = [
      ./remote-build-veridia.pub
      ./remote-build-elysia.pub
      ./remote-build-vapor.pub
    ];
  };

  users.groups.remotebuild = {};

  nix.settings.trusted-users = ["remotebuild"];
}
