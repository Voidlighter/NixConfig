{ pkgs, inputs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  # programs.bash.profileExtra = ''
  #   if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  #     exec uwsm start -S hyprland-uwsm.desktop
  #   fi
  # '';
  programs.noctalia-shell = {
    enable = true;
    settings = {
      bar = {
        density = "compact";
        position = "right";
        showCapsule = false;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              id = "WiFi";
            }
            {
              id = "Bluetooth";
            }
          ];
          center = [
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "none";
            }
          ];
          right = [
            {
              alwaysShowPercentage = false;
              id = "Battery";
              warningThreshold = 30;
            }
            {
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              id = "Clock";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
          ];
        };
      };
      # colorSchemes.predefinedScheme = "Monochrome";
      # settings = {
      #   templates = {
      #     enableUserTemplates = true;
      #   };
      # };
      # user-templates = ./path/to/user-templates.toml;
      # user-templates = ''
      #   [config]
      #   # General Matugen config settings
      #   [templates.myapp]
      #   input_path = "~/.config/noctalia/templates/myapp.css"
      #   output_path = "~/.config/myapp/theme.css"
      #   post_hook = "myapp --reload-theme"
      # ''
      # colors = {
      #   # you must set ALL of these
      #   mError = "#dddddd";
      #   mOnError = "#111111";
      #   mOnPrimary = "#111111";
      #   mOnSecondary = "#111111";
      #   mOnSurface = "#828282";
      #   mOnSurfaceVariant = "#5d5d5d";
      #   mOnTertiary = "#111111";
      #   mOnHover = "#ffffff";
      #   mOutline = "#3c3c3c";
      #   mPrimary = "#aaaaaa";
      #   mSecondary = "#a7a7a7";
      #   mShadow = "#000000";
      #   mSurface = "#111111";
      #   mHover = "#1f1f1f";
      #   mSurfaceVariant = "#191919";
      #   mTertiary = "#cccccc";
      # };
      general = {
        avatarImage = "/home/drfoobar/.face";
        radiusRatio = 0.2;
      };
      location = {
        monthBeforeDay = true;
        name = "Marseille, France";
      };
    };
    # this may also be a string or a path to a JSON file.
  };
}
