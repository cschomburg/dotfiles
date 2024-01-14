local lsp = require('plugins.lsp')

-- Bootstrap nvim-packer
do
    local execute = vim.api.nvim_command
    local fn = vim.fn

    local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

    if fn.empty(fn.glob(install_path)) > 0 then
      execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
      execute 'packadd packer.nvim'
    end
end

vim.cmd [[packadd packer.nvim]]

local function plugin_config(plugin)
    return string.format([[
        local fn = require(%q)
        if fn then fn() end
    ]], 'plugins.' .. plugin)
end

require('packer').startup(function ()
    use {'wbthomason/packer.nvim', opt = true}
    use { 'nvim-lua/plenary.nvim' }

    -- tpope essentials
    use { 'tpope/vim-surround' }
    use { 'tpope/vim-repeat' }
    use { 'tpope/vim-vinegar' }
    use { 'tpope/vim-fugitive' }
    use { 'tpope/vim-commentary' }
    use { 'tpope/vim-abolish' }
    use { 'tpope/vim-sleuth' }
    use { 'tpope/vim-dadbod' }

    -- colorschemes
    use 'sainnhe/gruvbox-material'
    use 'u-ra/vim-two-firewatch'
    use 'morhetz/gruvbox'
    use 'shaunsingh/nord.nvim'
    use 'atelierbram/Base2Tone-nvim'
    use 'catppuccin/nvim'
    use 'rose-pine/neovim'
    use {
        "mcchrish/zenbones.nvim",
        requires = "rktjmp/lush.nvim"
    }

    -- treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = plugin_config('treesitter'),
    }
    use {
        'romgrk/nvim-treesitter-context',
        requires = 'nvim-treesitter/nvim-treesitter'
    }

    -- misc
    use { 'nvim-lualine/lualine.nvim', config = plugin_config('lualine') }
    use 'junegunn/vim-easy-align'
    use { 'lewis6991/gitsigns.nvim' }
    use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
    use 'junegunn/fzf.vim'
    use 'simnalamburt/vim-mundo'
    use { 'NvChad/nvim-colorizer.lua', config = plugin_config('colorizer') }
    use 'ggandor/lightspeed.nvim'

    -- diagnostics & code completion
    use { 'neovim/nvim-lspconfig', config = plugin_config('lsp') }
    use { 'nvimtools/none-ls.nvim', config = plugin_config('null-ls') }
    use { 'folke/trouble.nvim', config = plugin_config('trouble') }
    use { 'hrsh7th/cmp-vsnip' }
    use { 'hrsh7th/vim-vsnip' }
    use { 'hrsh7th/vim-vsnip-integ' }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-cmdline' }
    use { 'hrsh7th/nvim-cmp', config = plugin_config('cmp') }
    use { 'ray-x/lsp_signature.nvim', config = plugin_config('lsp_signature') }
    use { 'github/copilot.vim' }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}}
    }
    use {
        'NTBBloodbath/rest.nvim',
        config = plugin_config('rest')
    }

    use {
        "nvim-neotest/neotest",
        requires = {
            "antoinemadec/FixCursorHold.nvim"
        },
        config = plugin_config('neotest')
    }

    -- language specific
    use { 'fatih/vim-go', ft = 'go' }
end)

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
