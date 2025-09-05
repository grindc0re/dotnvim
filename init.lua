-- Don't try to emulate vi.
vim.o.compatible = false

-- Allow backspacing over anything in insert mode.
vim.o.backspace='indent,eol,start'

-- Allow undo between sessions.
vim.o.undofile = true

-- Create swap-files to store changes between sessions.
-- Neovim will create swp-files in $HOME/.local/nvim/swap/ by default.
vim.o.swapfile = true

-- Save command entries history.
vim.o.history = 50

-- Show ruler.
vim.o.ruler = true

-- Show matches while typing a search string.
vim.o.incsearch = true

-- Highlight all search matches.
vim.o.hlsearch = true

-- Show current line number at cursor.
vim.o.number = true

-- Show relative line numbers.
vim.o.relativenumber = true

-- Highlight the cursor row.
-- vim.o.cursorline = true

-- Do not wrap lines by default.
vim.o.wrap = false

-- Default to utf-8 file encoding.
vim.o.encoding = 'utf-8'

-- Show ex-command popups.
vim.o.wildmenu = true

-- Set buffer/window separators.
vim.o.fillchars = 'stl: ,stlnc: ,vert:│,fold:-,diff:-'

-- Highlight whitespace characters.
vim.o.list = true
vim.o.listchars = 'trail:·,tab:» ,'

-- Clipboard.
vim.o.clipboard = 'unnamed,unnamedplus'

-- Default tab settings, prefer language specific indentation settings.
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.cmd('filetype plugin indent on')

-- Set updatetime to speed up gitgutter hints.
vim.o.updatetime = 100

-- ---------------------------------------------------------------------------------
-- Themes and colors
-- ---------------------------------------------------------------------------------

-- Use 24bit colors.
vim.o.termguicolors = true
vim.cmd('syntax enable')
vim.cmd('colorscheme onedark')

-- Diagnostic errors in signcolumn
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.INFO] = '  ',
      [vim.diagnostic.severity.HINT] = ' ',
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
    },
  }
})

-- ---------------------------------------------------------------------------------
-- Keymaps
-- ---------------------------------------------------------------------------------

vim.g.mapleader = ','
vim.g.maplocalleader = ' '

-- Using silent = true mean that the command is not added to the command history.
vim.api.nvim_set_keymap('n', '<leader>o', ':e ~/.config/nvim/init.lua<cr>', { noremap = true, silent = true })

-- Open fugitive in a fullscreen tab.
vim.api.nvim_set_keymap('n', '<leader>g', ':tab G<cr>', { noremap = true, silent = true })

-- Open file explorer.
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<cr>', { noremap = true, silent = true })

-- Quick save.
vim.api.nvim_set_keymap('n', '<leader>w', ':wa<cr>', { noremap = true })

-- Keep selection when shifting visual blocks.
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true })
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true })

-- Use jj to move one char to the right in insert mode.
vim.api.nvim_set_keymap('i', 'jj', '<esc>la', { noremap = true })

-- Enable escape in terminal.
vim.api.nvim_set_keymap('t', '<esc>', '<c-\\><c-n>', { noremap = true })

-- Center the last line when pressing G in normal mode.
vim.api.nvim_set_keymap('n', 'G', 'Gzz', { noremap = true })

-- Generate a random uuid when pressing Ctrl+u in insert mode.
vim.api.nvim_set_keymap('i', '<c-u>', '<c-r>=trim(system("uuidgen"))<cr>', { noremap = true })

-- Show documentation for the objects under the cursor.
vim.api.nvim_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<cr>', { noremap = true, silent = true})

-- Show diagnostic popup.
vim.api.nvim_set_keymap('n', '<leader>d', ':lua vim.diagnostic.open_float()<cr>', { noremap = true, silent = true})

-- ---------------------------------------------------------------------------------
-- Autocommands
-- ---------------------------------------------------------------------------------

-- When opening a file, always try to jump to the last known location.
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = {"*"},
  callback = function()
    if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.api.nvim_exec("normal! g'\"",false)
    end
  end
})

-- Softwrap markdown files at 80 chars.
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = {"*.md"},
  callback = function()
    vim.cmd('setlocal linebreak')
    vim.cmd('setlocal wrap')
  end
})

-- Set htmldjango as default filetype for html.
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = {"*.html"},
  callback = function()
    vim.cmd('set filetype=htmldjango')
  end
})

-- ---------------------------------------------------------------------------------
-- Plugin specific configurations
-- ---------------------------------------------------------------------------------

-- Quickscope
vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
vim.cmd('highlight QuickScopePrimary guifg=#afff5f gui=underline ctermfg=40 cterm=underline')
vim.cmd('highlight QuickScopeSecondary guifg=#5fffff gui=underline ctermfg=40 cterm=underline')

-- Lualine
require('lualine').setup({
  options = {
    theme = 'onedark',
    -- Do not show statusline in file tree.
    disabled_filetypes = { 'NvimTree' },
    -- Do not show separator between components in the same section.
    component_separators = "",
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding' },
    lualine_y = { 'filetype' },
    lualine_z = { 'progress', 'location' }
  },
})

-- nvim-tree
-- Disable netrw file tree.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require('nvim-tree').setup()

-- Gitgutter
vim.o.signcolumn = 'yes'
gitgutter_set_sign_backgrounds=1
vim.g.gitgutter_sign_added = '│'
vim.g.gitgutter_sign_modified = '│'
vim.g.gitgutter_sign_modified_removed = '│'
vim.g.gitgutter_sign_removed = '_'

-- Telescope
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

local telescope_buffers = function () 
  -- List buffers in last used order and ignore the current file
  -- to be able to jump between two files.
  builtin.buffers({ sort_lastused = true, ignore_current_buffer = true })
end

vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>sb', telescope_buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Telescope LSP diagnostics' })

-- For muscle memory
vim.keymap.set('n', 'gb', telescope_buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Telescope files' })

-- Navigate between matches using ctrl+j/k
require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
      },
    },
  }
}

-- Mason
require('mason').setup()

-- nvim-cmp - LSP
local cmp = require('cmp')
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
     -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<cr>'] = cmp.mapping.confirm({ select = true }),
    ['<tab>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' }
  }, {
    { name = 'buffer' },
  })
})
-- LSP-related keymaps.
vim.api.nvim_set_keymap('n', 'gd', ':lua vim.lsp.buf.definition()<cr>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gD', ':lua vim.lsp.buf.declaration()<cr>', { noremap = true, silent = true})

-- Enable language servers.
-- See here for names -->> https://github.com/neovim/nvim-lspconfig
vim.lsp.enable({ 
  'pyright',
  'cssls',
  'djlsp',
  'docker_compose_language_service',
  'dockerls',
  'html',
  'htmx',
  'jsonls',
  'tailwindcss',
})
