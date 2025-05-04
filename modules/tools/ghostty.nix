{ pkgs, ... }: # Ensure pkgs is passed into your home.nix function

{
  programs.ghostty = {
    enable = true;
    # package = pkgs.ghostty; # Optional: specify if using a non-default version
    enableZshIntegration = true;
    enableBashIntegration = false;
    settings = {
      # ... other ghostty settings ...
     unfocused-split-opacity = 0.20;
      font-size = 14; # Example [8]
      theme = "catppuccin-mocha"; # Example [12]
      background-opacity = 0.9; # Example [7, 8]
      background-blur-radius = 10; # Example [7, 8]

      # ... other ghostty settings ...
    };
  };

}
