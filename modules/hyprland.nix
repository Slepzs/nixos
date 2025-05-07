
# ./hyrpland.nix
{ pkgs, ... }: # You might need pkgs or other arguments depending on your needs

{
 wayland.windowManager.hyprland = {
    enable = true;
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    settings = {
      "$terminal" = "ghostty"; # or alacritty, or whatever you install 
      "$menu" = "wofi --show=drun"; # Define a variable for your launcher command

      exec-once = [
        "$terminal" # Launch a terminal on startup so you're not lost
        "waybar"
        # "swaybg -i /path/to/your/wallpaper.png" # Set a wallpaper (see Necessary Packages below)
        # "mako" # Start notification daemon (see Necessary Packages below)
      ];

      # Monitor configuration:
      # Replace YOUR_PREFERRED_PRIMARY_MONITOR_NAME and YOUR_SECONDARY_MONITOR_NAME
      # with the actual names from `hyprctl monitors`.
      # The monitor at position 0x0 will be your primary.
      # 'preferred' for resolution uses the monitor's native mode.
      # 'auto' for position of the secondary monitor lets Hyprland place it.
      monitor = [
        "DP-2,preferred,0x0,1"      # This will now be your primary monitor (leftmost)
        "HDMI-A-1,preferred,auto,1" # This will be to the right of DP-2
        # If you have more monitors, add them here following the same pattern.
        # Example: "DP-1,1920x1080@60,0x0,1"
        #          "HDMI-A-1,preferred,1920x0,1" (to the right of DP-1)
      ];

      input = {
        kb_layout = "us"; # CHANGE THIS to your layout (e.g., de, fr)
        follow_mouse = 1;
      };

      bind = [
        "SUPER, Q, killactive,"            # Close active window
        "SUPER, M, exit,"                  # Exit Hyprland (logout)
        "SUPER, RETURN, exec, $terminal"   # Open terminal (SUPER is usually the Windows key)
        # "SUPER, D, exec, wofi --show drun" # App launcher (see Necessary Packages below)
        "SUPER, ENTER, exec, $menu"
        "ALT, G, focusmonitor, 0"          # Focus second monitor (now ID 0 if previously ID 1)
        "SUPER, 1, movetoworkspace, 0" # move window to workspace 1 (on current monitor)
        "SUPER, 2, movetoworkspace, 1" # move window to workspace 2 (on current monitor)
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };
      decoration.rounding = 5;


    };
    package = null;
    portalPackage = null;
  };


}
