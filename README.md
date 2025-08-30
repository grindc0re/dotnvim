# dotnvim - Neovim config, grindc0re style

## Description
Using vim/neovims builtin package manager and submodules.

## Included plugins

```bash
$ tree pack/ -L 3
pack/
├── deps
│   └── start
│       ├── nvim-web-devicons
│       └── plenary.nvim
├── editing
│   └── start
│       ├── cmp-nvim-lsp
│       ├── cmp-nvim-lsp-signature-help
│       ├── markdown-preview.nvim
│       ├── mason.nvim
│       ├── nvim-cmp
│       ├── nvim-lspconfig
│       ├── nvim-treesitter
│       ├── quick-scope
│       └── vim-commentary
├── git
│   └── start
│       ├── vim-fugitive
│       └── vim-gitgutter
├── nav
│   └── start
│       ├── nvim-tree.lua
│       └── telescope.nvim
└── themes
    └── start
        ├── lualine.nvim
        └── onedark.nvim

28 directories, 0 files
```

## Install

Run: `git clone --recurse-submodules -j8 https://github.com/grindc0re/dotnvim.git ~/.config/nvim`

### LSP
`:MasonInstall css-lsp css-variables-language-server django-template-lsp docker-compose-language-service dockerfile-language-server html-lsp json-lsp lua-language-server pyright ruff shfmt sqlls stylua tailwindcss-language-server yaml-language-server`

### Treesitter
`:TSInstall bash css csv dockerfile editorconfig fennel gitignore html htmldjango jsdoc json json5 lua nginx python sql toml yaml`
