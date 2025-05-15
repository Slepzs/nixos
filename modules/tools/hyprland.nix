# modules/tools/hyprland.nix
{ pkgs, lib, config, ... }: # It's good practice to include lib and config for more complex modules

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
      "$menu" = "wofi --show=drun";
      "$mainMod" = "SUPER"; # Define mainMod for convenience

      exec-once = [
        "$terminal"
        "waybar"
        # "swaybg -i /path/to/your/wallpaper.png" # Ensure this path is valid or use a package
        # "mako"
      ];

      monitor = [
        "DP-2,preferred,0x0,1"
        "HDMI-A-1,preferred,auto,1"
        # Add other monitor configurations here if needed
      ];

      "workspace" = [
        "10, name:t, monitor:DP-2"
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
        "$mainMod, R, exec, $menu" # Changed from SUPER to $mainMod for consistency
        "$mainMod, P, pseudo," # dwindle
        "$mainMod, J, togglesplit," # dwindle

        # Move focus with $mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces with $mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        # ... and so on for other workspaces

        "ALT_SHIFT, F, fullscreen" # Note: Using ALT_SHIFT as per your original

        # Move active window to a workspace with ALT_SHIFT + [0-9]
        "ALT_SHIFT, 1, movetoworkspace, 1"
        "ALT_SHIFT, 2, movetoworkspace, 2"
        "ALT_SHIFT, 3, movetoworkspace, 3"
        "ALT_SHIFT, T, movetoworkspace, T" # Note: 'T' might conflict if it's a named workspace like 't' above. Consider using a number or different key.
        # ... and so on

        # Keybinding to enter the resize submap
        "$mainMod+SHIFT, R, submap, resizeMode" # Using $mainMod_SHIFT for SUPER+SHIFT
      ];







    }; # Closes settings

 # The submap definition and its internal bindings go into extraConfig
    extraConfig = ''
      # will start a submap called "resize"
      submap = resize

      # sets repeatable binds for resizing the active window within the 'resize' submap
      binde = , right, resizeactive, 10 0
      binde = , left, resizeactive, -10 0
      binde = , up, resizeactive, 0 -10
      binde = , down, resizeactive, 0 10

      # use reset to go back to the global submap from within the 'resize' submap
      bind = , escape, submap, reset 

      # will reset the submap, which will return to the global submap
      # Any keybinds defined after this in extraConfig or in hyprland.conf
      # would be global again.
      submap = reset

      # keybinds further down (if any were added here) would be global again...
      # Or, if you have more global binds in your settings.bind above,
      # those are naturally in the global context.
    ''; 


  }; # Closes wayland.windowManager.hyprland

  
} # Closes the main module definition
