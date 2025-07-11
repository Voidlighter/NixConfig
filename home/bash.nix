{
  config,
  osConfig,
  pkgs,
  ...
}: {
  programs.bash = {
    enable = true;
    # History settings
    historySize = 10000;
    # historyFileSize = 10000;
    # historyControl = [ "ignoredups" "ignorespace" ];
    # blesh.enable = true;

    shellAliases = {
      "..." = "../..";
      "...." = "../../..";
      # ls = "eza";
      ll = "ls -lah";
      grep = "grep --color=auto";
      ncg = "nix-collect-garbage --delete-old";
      ndot = "nix-collect-garbage --delete-older-than";
      show_path = "echo $PATH | tr ':' '\n'";

      nrs = "sudo nixos-rebuild switch --impure --flake ~/NixConfig#${osConfig.my.hostname}";
      nb = "sudo nixos-rebuild build --impure --flake ~/NixConfig#${osConfig.my.hostname}";
      ndb = "sudo nixos-rebuild dry-build --impure --flake ~/NixConfig#${osConfig.my.hostname}";
      nrb = "sudo nixos-rebuild boot --impure --flake ~/NixConfig#${osConfig.my.hostname}";

      hms = "home-manager switch --flake ~/NixConfig#${osConfig.my.user.name}@${osConfig.my.hostname}";
      hmb = "home-manager build --flake ~/NixConfig#${osConfig.my.user.name}@${osConfig.my.hostname}";
      hmdb = "home-manager dry-build --flake ~/NixConfig#${osConfig.my.user.name}@${osConfig.my.hostname}";
    };

    bashrcExtra = ''
      # Vi mode
      # set -o vi

      # Enable bash history substring search (not built-in like zsh)
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'

      # starship
      eval -- "$(starship init bash)"
      
      # devbox
      eval "$(devbox global shellenv)"
    '';
  };
  # config.xdg.configFile."starship.toml".source = lib.mkForce ./starship.toml;
}
