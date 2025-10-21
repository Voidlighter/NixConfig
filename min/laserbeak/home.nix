{ config, pkgs, ... }:

{
  config.users.users.cade = {
    # TODO please change the username & home directory to your own
    home.username = "cade";
    home.homeDirectory = "/home/cade";

    # Packages that should be installed to the user profile.
    home.packages = with pkgs; [
      # here is some command line tools I use frequently
      # feel free to add your own or remove some of them
      fastfetch
      cowsay
    ];

    # basic configuration of git, please change to your own
    programs.git = {
      enable = true;
      userName = "Cade";
      userEmail = "voidlighter@proton.me";
    };

    # starship - an customizable prompt for any shell
    programs.starship = {
      enable = true;
      # custom settings
      settings = {
        add_newline = false;
        aws.disabled = true;
        gcloud.disabled = true;
        line_break.disabled = true;
      };
    };

    # alacritty - a cross-platform, GPU-accelerated terminal emulator
    programs.alacritty = {
      enable = true;
      # custom settings
      settings = {
        env.TERM = "xterm-256color";
        font = {
          size = 12;
          draw_bold_text_with_bright_colors = true;
        };
        scrolling.multiplier = 5;
        selection.save_to_clipboard = true;
      };
    };

    programs.bash = {
      enable = true;
      enableCompletion = true;
    };

    # Don't change this manually. Read the manual.
    home.stateVersion = "25.05";
  };
}
