# modules/tools/hyprland.nix
{ pkgs, lib, config, ... }: # It's good practice to include lib and config for more complex modules

let
  # Define the path to your wallpaper. Nix will make this an absolute path to the file in the Nix store.
  # Adjusted path for when this file is moved to modules/tools/hyprland/default.nix
  wallpaperPath = ../../wallpapers/wallpaper.jpg;

  # Import animation settings. This path is relative to the new location of this file.
  animationsSettings = import ./animations.nix;
in
{
  # This defines a home-manager module option, allowing you to enable/disable hyprland setup easily.
  # You could also directly configure wayland.windowManager.hyprland here if not making it optional.
  # For simplicity, I'll assume direct configuration as per your original structure.

  wayland.windowManager.hyprland = {
    enable = true;
    # package = pkgs.hyprland; # Explicitly use home-manager's package, or set to null for system's
    # xdgPortalHyprlandPackage = pkgs.xdg-desktop-portal-hyprland; # If needed

    settings = {
      "$terminal" = "ghostty";
      "$menu" = "rofi -show drun"; # Changed wofi to rofi
      "$mainMod" = "SUPER"; # Define mainMod for convenience

      exec-once = [
        "$terminal"
        "waybar"
        "swaybg -o '*' -i ${wallpaperPath}" # Wallpaper path managed by Nix, explicitly target all outputs
        "wl-paste --watch cliphist store"
        # "mako"
      ];

      monitor = [
        "DP-2,preferred,0x0,1"
        "HDMI-A-1,preferred,auto,1"
        # Add other monitor configurations here if needed
      ];

      "workspace" = [
        "1, monitor:DP-2"
        "2, monitor:DP-2"
        "3, monitor:HDMI-A-1" 
        "4, monitor:HDMI-A-1" 
        "name:t, monitor:DP-2"
        "name:g, monitor:HDMI-A-1"
        "name:p, monitor:HDMI-A-1"
        "name:b, monitor:DP-2"
        "name:n, monitor:DP-2"
        "name:m, monitor:DP-2"
        "name:s, monitor:DP-2"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        repeat_delay = 250;
        repeat_rate = 35;
        # You might want to add more input settings, e.g., tap-to-click for touchpads
        # touchdevice = {
        #   output = "*"; # Apply to all touch devices
        #   enabled = true;
        #   # Add other touch device settings as needed
        # };
        # touchpad = {
        #   natural_scroll = true; # example
        #   disable_while_typing = true; # example
        # };
      }; # Closes input

      # Example: Adding some general settings
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle"; # or master
      };
      animations = animationsSettings; # Add the imported animation settings
      dwindle = {
        preserve_split = true;
        # smart_resizing = false;
      };

      # Main keybindings
      bind = [
        "$mainMod, Q, killactive,"
        "$mainMod, M, exit,"
        # "$mainMod, E, exec, nemo" # Example: file manager, ensure 'nemo' is installed
        "$mainMod, V, togglefloating,"
        "$mainMod, RETURN, exec, $menu" # Added Super + Enter for Rofi
        "$mainMod, R, exec, $menu" # Changed from SUPER to $mainMod for consistency
        "$mainMod, P, pseudo," # dwindle
        "$mainMod, J, togglesplit," # dwindle

        # Move focus with $mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Move focus with ALT + H/J/K/L (vim-like)
        "ALT, H, movefocus, l" # h for left
        "ALT, J, movefocus, d" # j for down
        "ALT, K, movefocus, u" # k for up
        "ALT, L, movefocus, r" # l for right

        # Swap windows with ALT_SHIFT + h/j/k/l
        "ALT_SHIFT, H, swapwindow, l" # h for left
        "ALT_SHIFT, J, swapwindow, d" # j for down
        "ALT_SHIFT, K, swapwindow, u" # k for up
        "ALT_SHIFT, L, swapwindow, r" # l for right


        "ALT_SHIFT, F, fullscreen" # Note: Using ALT_SHIFT as per your original


        # Switch workspaces with ALT_SHIFT + [0-9]
        "$mainMod_SHIFT, 1, workspace, 1"
        "$mainMod_SHIFT, 2, workspace, 2"
        "$mainMod_SHIFT, 3, workspace, 3"
        
      # Switch to other named workspaces using ALT_SHIFT + letter
        "$mainMod_SHIFT, G, workspace, name:g"
        "$mainMod_SHIFT, B, workspace, name:b"
        "$mainMod_SHIFT, N, workspace, name:n"
        "$mainMod_SHIFT, M, workspace, name:m"
        "$mainMod_SHIFT, T, workspace, name:t"
        "$mainMod_SHIFT, P, workspace, name:p"
        "$mainMod_SHIFT, S, workspace, name:s"

        # Keybinding to enter the resize submap
        "ALT_SHIFT, R, submap, resize" # Changed to ALT_SHIFT, R and submap name to 'resize'
        # Keybinding to enter the movewindow submap
        "ALT_SHIFT, V, submap, movewindow"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
      ];







    }; # Closes settings

 # The submap definition and its internal bindings go into extraConfig
    extraConfig = ''
      # will start a submap called "resize"
      submap = resize

      # sets repeatable binds for resizing the active window within the 'resize' submap
      # h j k l for left, down, up, right (vim-like)
      binde = , h, resizeactive, -10 0  # Resize left
      binde = , j, resizeactive, 0 10   # Resize down
      binde = , k, resizeactive, 0 -10  # Resize up
      binde = , l, resizeactive, 10 0   # Resize right

      bind = , f, togglefloating,        # Toggle floating with f

      # use reset to go back to the global submap from within the 'resize' submap
      bind = , escape, submap, reset

      # will reset the submap, which will return to the global submap
      # Any keybinds defined after this in extraConfig or in hyprland.conf
      # would be global again.
      submap = reset

      # --- movewindow submap ---
      # will start a submap called "movewindow"
      submap = movewindow

      # binds for moving the active window to a workspace within the 'movewindow' submap
      bind = , 1, movetoworkspace, 1
      bind = , 2, movetoworkspace, 2
      bind = , 3, movetoworkspace, 3
      # bind = , 4, movetoworkspace, 4 # Add more numbers if you have them defined
      # bind = , 5, movetoworkspace, 5
      # ...

      bind = , T, movetoworkspace, name:t
      bind = , G, movetoworkspace, name:g
      bind = , B, movetoworkspace, name:b
      bind = , N, movetoworkspace, name:n
      bind = , M, movetoworkspace, name:m
      bind = , P, movetoworkspace, name:p
      bind = , S, movetoworkspace, name:s

      # use reset to go back to the global submap from within the 'movewindow' submap
      bind = , escape, submap, reset

      # will reset the submap, which will return to the global submap
      submap = reset
      # --- end of movewindow submap ---

      # keybinds further down (if any were added here) would be global again...
      # Or, if you have more global binds in your settings.bind above,
      # those are naturally in the global context.
    ''; 


  }; # Closes wayland.windowManager.hyprland

 
} # Closes the main module definition
