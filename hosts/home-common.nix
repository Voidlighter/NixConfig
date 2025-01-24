{
  osConfig,
  inputs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    ./../modules/home-manager/zsh.nix
    ./../modules/home-manager/starship.nix
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    # nix-index-database.hmModules.nix-index
    inputs.plasma-manager.homeManagerModules.plasma-manager
    # inputs.musnix.nixosModules.musnix
  ];

  # config = {
  # users.${osConfig.my.user.name} = {
  home = {
    stateVersion = "24.05";
    username = "${osConfig.my.user.name}";
    homeDirectory = "/home/${osConfig.my.user.name}";

    sessionVariables = {
      EDITOR = "nvim";
    };
    file = {
    };

    packages = osConfig.my.app.list;
  };

  fonts.fontconfig.enable = true;

  programs = {
    home-manager = {
      enable = true;
    };

    git = {
      enable = true;
      userName = "voidlighter";
      userEmail = "voidlighter@proton.me";
      aliases = {};
    };

    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };

    nix-index.enable = true;
    nix-index.enableZshIntegration = true;
    #     nix-index-database.comma.enable = true;

    konsole = {
      enable = true;
    };
    eza = {
      enable = true;
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  # basically don't change this. It isn't the version number
  # home.stateVersion = "24.05";
  # };
  #   };
  # };
}
