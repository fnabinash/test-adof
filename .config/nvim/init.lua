-- Ensure lazy.nvim is installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Key mappings
vim.g.mapleader = ' '              -- Map leader key to space

-- Basic settings
vim.opt.number = true              -- Show line numbers
vim.opt.relativenumber = true      -- Enable relative line number
vim.opt.tabstop = 4                -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 4             -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true           -- Use spaces instead of tabs
vim.opt.autoindent = true          -- Copy indent from current line when starting a new line
vim.opt.smartindent = true         -- Smart auto indenting for C-like programs
vim.opt.hlsearch = true            -- Highlight search results
vim.opt.incsearch = true           -- Incremental search
vim.opt.ignorecase = true          -- Case insensitive searching
vim.opt.smartcase = true           -- Case sensitive searching if pattern contains uppercase letters
vim.opt.clipboard = 'unnamedplus'

-- Ensure the lazy.nvim directory is in the run time path
vim.opt.rtp:prepend('~/.config/nvim/lua/lazy.nvim')

-- Lazy.nvim configuration
require("lazy").setup({
  { "junegunn/seoul256.vim" },
  { "windwp/nvim-autopairs" },
  { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } },
  { 'AlexvZyl/nordic.nvim', priority = 1000 }, -- Add the Nordic theme
})

-- Configure lualine
require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '|', right = '|' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = {
      {
        'filename',
        file_status = true,  -- Displays file status (read only status, modified status)
        path = 1,            -- 0: Just the file name
                             -- 1: Relative path
                             -- 2: Absolute path
                             -- 3: Absolute path, with tilde as the home directory

        shorting_target = 40, -- Shortens path to leave 40 spaces in the window
                              -- for other components. (terrible name, any suggestions?)
        symbols = {
          modified = '[+]',      -- Text to show when the file is modified.
          readonly = '[-]',      -- Text to show when the file is non-modifiable or read only.
          unnamed = '[No Name]', -- Text to show for unnamed buffers.
        }
      }
    },
    lualine_x = { 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
})

-- nvim-autopairs configuration
require('nvim-autopairs').setup{}

-- Set the Nordic theme
vim.cmd('colorscheme nordic')

-- Override the background color to make it darker
vim.cmd('highlight Normal guibg=#121212')
vim.cmd('highlight NormalFloat guibg=#121212')
vim.cmd('highlight SignColumn guibg=#121212')
vim.cmd('highlight LineNr guibg=#121212')
vim.cmd('highlight Folded guibg=#121212')
vim.cmd('highlight NonText guibg=#121212')
vim.cmd('highlight LineNr guifg=#7f8082')
vim.cmd('highlight Visual guibg=#4d4d4d')
vim.cmd('highlight VisualNOS guibg=#4d4d4d')
vim.cmd('highlight Comment guifg=#6483b0 gui=NONE')

-- Spell-check settings
vim.opt.spell = false                    -- Start with spell-check off
vim.opt.spelllang = "en"                 -- Set spell-check language to English

-- Define custom highlight for misspelled words
vim.cmd([[
  highlight SpellBad cterm=underline ctermbg=NONE ctermfg=NONE gui=undercurl guibg=#b9636b guifg=#121212
]])

-- Keybinding to toggle spell-check on/off
vim.api.nvim_set_keymap('n', '<leader>s', ':set spell!<CR>', { noremap = true, silent = true })
