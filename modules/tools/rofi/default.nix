{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland; # Ensures Wayland compatibility for Hyprland

    # Basic configuration using extraConfig.
    # For more advanced theming, you can use the `theme` option provided by
    # the home-manager module, or create a custom config.rasi via xdg.configFile.
    extraConfig = {
      modi = "drun,run,window";    # Enable modes for applications, commands, and window switching
      show-icons = true;           # Display icons for applications
      icon-theme = "Papirus";      # Set an icon theme. You'll need to install this theme.
      terminal = "${pkgs.ghostty}/bin/ghostty"; # Specify the terminal Rofi should use
      drun-display-format = "{name}"; # Format for application names in drun mode
    };

    # // If you have a specific theme like "gruvbox-dark" that Rofi can find,
    # // you can uncomment and set it here:
    theme = ./theme/adi1090x-style2.rasi;
  };
}
