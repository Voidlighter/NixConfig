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
      gc = "nix-collect-garbage --delete-old";
      show_path = "echo $PATH | tr ':' '\n'";

      nrs = "sudo nixos-rebuild switch --verbose --impure --flake ~/NixConfig#${osConfig.my.hostname}";

      gapa = "git add --patch";
      grpa = "git reset --patch";
      gtruest = "git status";
      gdh = "git diff HEAD";
      gp = "git push";
      gph = "git push -u origin HEAD";
      gco = "git checkout";
      gcob = "git checkout -b";
      gcm = "git checkout master";
      gcd = "git checkout develop";
    };

    bashrcExtra = ''
      # Vi mode
      set -o vi

      # Enable bash history substring search (not built-in like zsh)
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'

      # starship
      eval -- "$(/etc/profiles/per-user/cade/bin/starship init bash --print-full-init)"
    '';
  };
  # config.xdg.configFile."starship.toml".source = lib.mkForce ./starship.toml;
}
