{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  imports = [
    ./programs/neovim/neovim.nix
  ];
  home.username = "psiayn";
  home.homeDirectory = "/home/psiayn";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";
  home.packages = with pkgs; [
    neofetch
    git
    flameshot
    htop
    tmux
    python310
    direnv
    lorri
    tree
    # nvim + lsp
    tree-sitter
    nodejs
    rnix-lsp
    xclip
  ];

  programs.git = {
    enable = true;
    userName = "Pranav Kesavarapu";
    userEmail = "pranavkesavarapu@gmail.com";
    extraConfig.diff.tool = "nvimdiff";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
