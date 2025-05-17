{
  # Hyprland animation settings
  # For more details, see: https://wiki.hyprland.org/Configuring/Animations/

  enabled = true;

  bezier = [
    "myBezier, 0.05, 0.9, 0.1, 1.05"
    "linear, 0.0, 0.0, 1.0, 1.0"
    "smoothOut, 0.36, 0, 0.66, -0.56"
    "smoothIn, 0.25, 1, 0.5, 1"
    "overshot, 0.05,0.9,0.1,1.1" # A bit of an overshoot
  ];

  animation = [
    "windowsIn, 1, 7, myBezier, slide"             # Windows opening
    "windowsOut, 1, 7, smoothOut, slide"           # Windows closing
    "windowsMove, 1, 7, myBezier, slide"           # Windows moving
    "border, 1, 10, linear"                        # Border animation
    "borderangle, 1, 30, linear, loop"             # Border angle animation (e.g., for rounded corners)
    "fade, 1, 7, smoothIn"                         # Fade animations (e.g., for popups)
    "workspaces, 1, 6, myBezier, slide"            # Workspace switching
    # "specialWorkspace, 1, 3, myBezier, slidevert" # Example for special (scratchpad) workspaces
  ];
}
