local lsp = require('plugins.lsp')

-- Bootstrap lazy.nvim
do
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
      vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
      })
    end
    vim.opt.rtp:prepend(lazypath)
end

vim.cmd [[packadd packer.nvim]]

local function plugin_config(plugin)
    return function()
        local fn = require('plugins.' .. plugin)
        if fn then fn() end
    end
end

require('lazy').setup({
    'nvim-lua/plenary.nvim',

    -- tpope essentials
    'tpope/vim-surround',
    'tpope/vim-repeat',
    'tpope/vim-vinegar',
    'tpope/vim-fugitive',
    'tpope/vim-commentary',
    'tpope/vim-abolish',
    'tpope/vim-sleuth',
    'tpope/vim-dadbod',

    -- colorschemes
    'sainnhe/gruvbox-material',
    'u-ra/vim-two-firewatch',
    'morhetz/gruvbox',
    'shaunsingh/nord.nvim',
    'atelierbram/Base2Tone-nvim',
    'catppuccin/nvim',
    'rose-pine/neovim',
    { "mcchrish/zenbones.nvim", dependencies = { "rktjmp/lush.nvim" } },

    -- treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = plugin_config('treesitter'),
    },
    {
        'romgrk/nvim-treesitter-context',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
    },

    -- misc
    { 'nvim-lualine/lualine.nvim', config = plugin_config('lualine') },
    'junegunn/vim-easy-align',
    { 'lewis6991/gitsigns.nvim' },
    { 'junegunn/fzf' },
    'junegunn/fzf.vim',
    'simnalamburt/vim-mundo',
    { 'NvChad/nvim-colorizer.lua', config = plugin_config('colorizer') },
    'ggandor/lightspeed.nvim',

    -- diagnostics & code completion
    { 'neovim/nvim-lspconfig', config = plugin_config('lsp') },
    { 'nvimtools/none-ls.nvim', config = plugin_config('null-ls') },
    { 'folke/trouble.nvim', config = plugin_config('trouble') },
    { 'hrsh7th/cmp-vsnip' },
    { 'hrsh7th/vim-vsnip' },
    { 'hrsh7th/vim-vsnip-integ' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    { 'hrsh7th/nvim-cmp', config = plugin_config('cmp') },
    { 'ray-x/lsp_signature.nvim', config = plugin_config('lsp_signature') },
    { 'github/copilot.vim' },

    {
        'nvim-telescope/telescope.nvim',
        dependencies = {'nvim-lua/popup.nvim'}
    },

    {
        "nvim-neotest/neotest",
        dependencies = {
            "antoinemadec/FixCursorHold.nvim"
        },
        config = plugin_config('neotest')
    },

    -- language specific
    { 'fatih/vim-go', ft = 'go' },
})

-- general plugin configuration
do
    vim.g.go_fmt_autosave = 1
    vim.g.go_imports_autosave = 1

    vim.g.gitgutter_terminal_reports_focus = 0
    vim.g.gitgutter_grep = ''

    vim.g.indentLine_color_term = 235
    vim.g.indentLine_color_gui = '#393f47'

    vim.g.fzf_layout = { window = { width = 0.9, height = 0.6 } }

    vim.g.netrw_liststyle = 3

    vim.g.nv_search_paths = { '~/sync/0-essential/notes', './notes', './doc', './docs' }

    vim.g.slime_target = "tmux"
    vim.g.slime_default_config = { socket_name ='default', target_pane = '{last}' }

    vim.g.mundo_width = 100
    vim.g.mundo_right = 1

    vim.g.nord_borders = true;

    require('gitsigns').setup()
end
