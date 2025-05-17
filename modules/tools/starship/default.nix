{ config, pkgs, ... }:

{
programs.starship = {
    enable = true;
    # Automatically adds the Starship init script to your .zshrc
    # Enable integration with Zsh (this is usually automatic if programs.zsh.enable = true)
    enableZshIntegration = true;
    settings = builtins.fromTOML (builtins.readFile ./starship.toml);

    # Optional: Configure Starship settings directly in Nix
    # This maps directly to the structure of starship.toml
};



}
