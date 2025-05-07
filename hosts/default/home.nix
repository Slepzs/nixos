{ config, pkgs, ... }:

{
  imports = [
    ../../modules/tools/zsh.nix
    ../../modules/tools/ghostty.nix
    ../../modules/tools/starship.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tobias";
  home.homeDirectory = "/home/tobias";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.



  nixpkgs.config.allowUnfree = true;
  
  programs.zsh.enable = true;  
  
  programs.kitty.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    settings = {
      "$terminal" = "ghostty"; # or alacritty, or whatever you install 
      "$menu" = "${pkgs.wofi}/bin/wofi --show drun"; # Define a variable for your launcher command

      exec-once = [
        "$terminal" # Launch a terminal on startup so you're not lost
        # "swaybg -i /path/to/your/wallpaper.png" # Set a wallpaper (see Necessary Packages below)
        # "mako" # Start notification daemon (see Necessary Packages below)
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
        "SUPER, D exec, $menu"
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

  # Enable zoxide integration
  programs.zoxide = {
    enable = true;
    # Optional: if you want the 'zi' interactive selection alias too
    enableZshIntegration = true; # This is often implied by programs.zsh.enable but good to be explicit
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    ripgrep
    fd
    bat
    zoxide
    spotify
    obsidian
    alacritty
    wofi
    mako
    wl-clipboard

    # Development stuff
    python3
    nodejs
    docker-client # Docker daemon is usually a system service
    gh
    lazygit
    aider-chat
    devenv
    # Fonts

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/tobias/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
