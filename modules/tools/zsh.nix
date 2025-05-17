# ./zsh.nix
{ pkgs, ... }: # You might need pkgs or other arguments depending on your needs

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos"; # Or home-manager switch
      gc = "nix-collect-garbage -d";
      ghelp = "ghostty +list-keybinds --default";
      xaider = "aider --no-auto-commit --model gemini";
    };
    initContent = ''
      # Set editor environment variables
      export EDITOR=nvim
      export VISUAL="$EDITOR"
      export GEMINI_API_KEY=AIzaSyA8ScMLe82pez3wijWEYUlQTRRhhi2fuTQ

      # Source Ghostty shell integration script
      if [ -f "${pkgs.ghostty}/share/ghostty/integration/ghostty.sh" ]; then
        source "${pkgs.ghostty}/share/ghostty/integration/ghostty.sh"
      fi
    '';
    # ... other zsh settings
  };

  # You could also put related packages here if desired
  # home.packages = [ pkgs.zsh-powerlevel10k ];
}
