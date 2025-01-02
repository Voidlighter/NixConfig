{
  users.users.remotebuild = {
    isNormalUser = true;
    createHome = false;
    group = "remotebuild";

    # openssh.authorizedKeys.keyFiles = [
    #   /root/.ssh/remote-build-veridia.pub
    #   /root/.ssh/remote-build-elysia.pub
    #   /root/.ssh/remote-build-vapor.pub
    # ];
  };

  users.groups.remotebuild = {};

  nix.settings.trusted-users = ["remotebuild"];
}
