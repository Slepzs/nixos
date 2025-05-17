{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    # The 'style' option takes the CSS content directly.
    # We read your style.css file and pass its content here.
    style = builtins.readFile ./style.css;

    # We are not using the 'settings' attribute here because
    # it expects a Nix attribute set which would be converted to pure JSON.
    # To use your JSONC file (which can have comments), we'll symlink it directly
    # using home.file below.
  };

  # This creates a symlink from ~/.config/waybar/config to your config.jsonc file.
  # Waybar looks for a file named 'config' in its directory.
  home.file.".config/waybar/config" = {
    source = ./config.jsonc;
    # Ensures that home-manager knows this file is part of the waybar package's config
    # and can manage it accordingly (e.g. for activation scripts or dependencies).
    # While not strictly necessary for a simple symlink to work, it's good practice.
    # However, for direct symlinking of config files, 'source' is the primary mechanism.
    # If Waybar itself needs to be a target for activation, that's handled by programs.waybar.enable.
  };

  # Ensure the waybar package is installed.
  # This is often also in your main home.nix home.packages,
  # but including it here makes the module more self-contained.
  # If it's already in home.nix, this is redundant but harmless.
  home.packages = [ pkgs.waybar ];
}
