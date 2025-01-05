# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  config,
  pkgs,
  user,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    #     nix-index-database.hmModules.nix-index
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./theme-files/gruvbox-plus.nix
  ];

  options = {};

  config = {
    home = {
      username = "${user.name}";
      homeDirectory = "/home/${user.name}";

      sessionVariables = {
        EDITOR = "nvim";
      };
      file = {
      };
    };

    # Theming
    qt.enable = true;

    # platform theme "gtk" or "gnome"
    qt.platformTheme = "gtk";

    # name of the qt theme
    qt.style.name = "adwaita-dark";

    # detected automatically:
    # adwaita, adwaita-dark, adwaita-highcontrast,
    # adwaita-highcontrastinverse, breeze,
    # bb10bright, bb10dark, cde, cleanlooks,
    # gtk2, motif, plastique

    # package to use
    qt.style.package = pkgs.adwaita-qt;

    gtk.enable = true;

    gtk.cursorTheme.package = pkgs.bibata-cursors;
    gtk.cursorTheme.name = "Bibata-Modern-Classic";

    gtk.theme.package = pkgs.adw-gtk3;
    gtk.theme.name = "adw-gtk3";

    gtk.iconTheme.package = pkgs.papirus-icon-theme;
    gtk.iconTheme.name = "Papirus";

    # basically, same as above
    home.file = {
      ".icons/bibata".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic";
    };

    nixpkgs = {
      # You can add overlays here
      overlays = [
        # Add overlays your own flake exports (from overlays and pkgs dir):
        outputs.overlays.additions
        outputs.overlays.modifications
        outputs.overlays.unstable-packages

        # If you want to use overlays exported from other flakes:
        # neovim-nightly-overlay.overlays.default

        (final: prev: {
          unstable = import inputs.nixpkgs-unstable {
            system = final.system;
            config.allowUnfree = true;
          };
        })
      ];
      # Configure your nixpkgs instance
      config = {
        # Disable if you don't want unfree packages
        allowUnfree = true;
        # Workaround for https://github.com/nix-community/home-manager/issues/2942
        allowUnfreePredicate = _: true;
      };
    };

    programs = {
      home-manager.enable = true;

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

      starship = {
        enable = true;
        presets = ["tokyo-night"];
        settings = {
          gcloud.disabled = true;
          git_branch.style = "242";
          directory.style = "blue";
          directory.truncate_to_repo = true;
          directory.truncation_length = 3;
          python.disabled = true;
          ruby.disabled = true;
          hostname.ssh_only = false;
          hostname.style = "bold green";
        };
      };

      eza = {
        enable = true;
      };
      # This is where .zshrc stuff goes
      zsh = {
        enable = true;
        autocd = true;
        autosuggestion.enable = true;
        enableCompletion = true;
        defaultKeymap = "viins";
        history.size = 10000;
        history.save = 10000;
        history.expireDuplicatesFirst = true;
        history.ignoreDups = true;
        history.ignoreSpace = true;
        historySubstringSearch.enable = true;

        plugins = [
          {
            name = "fast-syntax-highlighting";
            src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
          }
          {
            name = "zsh-nix-shell";
            file = "nix-shell.plugin.zsh";
            src = pkgs.fetchFromGitHub {
              owner = "chisui";
              repo = "zsh-nix-shell";
              rev = "v0.5.0";
              sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
            };
          }
          {
            name = "vi-mode";
            src = pkgs.zsh-vi-mode;
            file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
          }
        ];

        shellAliases = {
          "..." = "./..";
          "...." = "././..";
          cd = "z";
          ls = "eza";
          gc = "nix-collect-garbage --delete-old";
          refresh = "source ${config.home.homeDirectory}/.zshrc";
          show_path = "echo $PATH | tr ':' '\n'";

          gapa = "git add --patch";
          grpa = "git reset --patch";
          gst = "git status";
          gdh = "git diff HEAD";
          gp = "git push";
          gph = "git push -u origin HEAD";
          gco = "git checkout";
          gcob = "git checkout -b";
          gcm = "git checkout master";
          gcd = "git checkout develop";
        };

        envExtra = ''
          export PATH=$PATH:$HOME/.local/bin
        '';

        initExtra = ''
          bindkey '^p' history-search-backward
          bindkey '^n' history-search-forward
          bindkey '^e' end-of-line
          bindkey '^w' forward-word
          bindkey "^[[3~" delete-char
          bindkey ";5C" forward-word
          bindkey ";5D" backward-word

          zstyle ':completion:*:*:*:*:*' menu select

          # Complete . and .. special directories
          zstyle ':completion:*' special-dirs true

          zstyle ':completion:*' list-colors ""
          zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

          # disable named-directories autocompletion
          zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

          # Use caching so that commands like apt and dpkg complete are useable
          zstyle ':completion:*' use-cache on
          zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

          # Don't complete uninteresting users
          zstyle ':completion:*:*:*:users' ignored-patterns \
                  adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
                  clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
                  gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
                  ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
                  named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
                  operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
                  rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
                  usbmux uucp vcsa wwwrun xfs '_*'
          # ... unless we really want to.
          zstyle '*' single-ignored complete

          # https://thevaluable.dev/zsh-completion-guide-examples/
          zstyle ':completion:*' completer _extensions _complete _approximate
          zstyle ':completion:*:descriptions' format '%F{green}-- %d --%f'
          zstyle ':completion:*' group-name ""
          zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands
          zstyle ':completion:*' squeeze-slashes true
          zstyle ':completion:*' matcher-list "" 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

          # mkcd is equivalent to takedir
          function mkcd takedir() {
            mkdir -p $@ && cd ''${@:$#}
          }

          function takeurl() {
            local data thedir
            data="$(mktemp)"
            curl -L "$1" > "$data"
            tar xf "$data"
            thedir="$(tar tf "$data" | head -n 1)"
            rm "$data"
            cd "$thedir"
          }

          function takegit() {
            git clone "$1"
            cd "$(basename ''${1%%.git})"
          }

          function take() {
            if [[ $1 =~ ^(https?|ftp).*\.(tar\.(gz|bz2|xz)|tgz)$ ]]; then
              takeurl "$1"
            elif [[ $1 =~ ^([A-Za-z0-9]\+@|https?|git|ssh|ftps?|rsync).*\.git/?$ ]]; then
              takegit "$1"
            else
              takedir "$@"
            fi
          }

          WORDCHARS='*?[]~=&;!#$%^(){}<>'

          # fixes duplication of commands when using tab-completion
          export LANG=C.UTF-8

          eval "$(zoxide init zsh)"
        '';
      };
    };

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    # basically don't change this. It isn't the version number
    home.stateVersion = "24.05";
  };
}
