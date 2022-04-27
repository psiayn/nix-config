with builtins;
{ config, pkgs, ... }: let
  nvim-lsp-installer = pkgs.vimUtils.buildVimPlugin rec {
    pname = "nvim-lsp-installer";
    version = "0bbc4b5402c63e285ce924fbe3f872cb8a5f6595";
    src = pkgs.fetchFromGitHub {
      owner = "williamboman";
      repo = "nvim-lsp-installer";
      rev = version;
      sha256 = "dY+Zw/woyl5aqe+l44TltAfnSLGQD2gkZzGTOZl/SP4=";
    };
  };
  rust-tools = pkgs.vimUtils.buildVimPlugin rec {
    pname = "rust-tools";
    version = "8922a58459bb6083325327cc26bde94c05b51600";
    src = pkgs.fetchFromGitHub {
      owner = "simrat39";
      repo = "rust-tools";
      rev = version;
      sha256 = "dY+Zw/woyl5aqe+l44TltAfnSLGQD2gkZzGTOZl/SP4=";
    };
  };
  lsp-zero = pkgs.vimUtils.buildVimPlugin rec {
    pname = "lsp-zero";
    version = "e6f46b68edebbce73a18ab0856df2da703b748b3";
    src = pkgs.fetchFromGitHub {
      owner = "VonHeikemen";
      repo = "lsp-zero.nvim";
      rev = version;
      sha256 = "dY+Zw/woyl5aqe+l44TltAfnSLGQD2gkZzGTOZl/SP4=";
    };
  };
  nvimPlugin = import ./plugin.nix;
  mkBefore = pkgs.lib.mkBefore;
in {
  xdg.configFile."nvim/init.vim".text = mkBefore ''
filetype plugin indent on
syntax enable
set nu
set mouse=a
set colorcolumn=80
nnoremap <SPACE> <Nop>
let mapleader=" "
set laststatus=3
autocmd Filetype lua,javascript,typescript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set splitbelow
set splitright
colorscheme terafox
  '';
  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      # nix
      vim-nix
      # theme
      nightfox-nvim
      # misc
      nvim-web-devicons
      (nvimPlugin nvim-tree-lua ''
        lua require'nvim-tree'.setup{}
        nnoremap <leader>t :NvimTreeToggle<CR>
        nnoremap <leader>r :NvimTreeRefresh<CR>
        nnoremap <leader>n :NvimTreeFindFile<CR>
      '')
      plenary-nvim
      (nvimPlugin galaxyline-nvim "lua require('galaxyline.themes.eviline')")
      nvim-treesitter
      # lsp goodies
      nvim-lspconfig
      cmp-nvim-lsp
      cmp_luasnip
      nvim-cmp
      luasnip
      nvim-lsp-installer
      lsp-zero
      rust-tools-nvim
      # general goodies
      gitsigns-nvim
      kommentary
      neogit
      (nvimPlugin telescope-nvim ''
        nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
        nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
        nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
        nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
      '')
      (nvimPlugin twilight-nvim ''
        lua require("twilight").setup{}
        nnoremap <leader>tw <cmd>Twilight<cr>
      '')
    ];
  };
  xdg.configFile."nvim/lua" = {
      recursive = true;
      source = ./lua;
  };
}
