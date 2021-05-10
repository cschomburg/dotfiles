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

    -- tpope essentials
    use { 'tpope/vim-surround' }
    use { 'tpope/vim-repeat' }
    use { 'tpope/vim-vinegar' }
    use { 'tpope/vim-fugitive' }
    use { 'tpope/vim-commentary' }
    use { 'tpope/vim-abolish' }

    -- colorschemes
    use 'sainnhe/gruvbox-material'
    use 'sainnhe/sonokai'
    use 'u-ra/vim-two-firewatch'
    use 'morhetz/gruvbox'
    use 'lifepillar/vim-solarized8'
    use 'arcticicestudio/nord-vim'

    -- syntax
    use 'plasticboy/vim-markdown'
    -- use 'sheerun/vim-polyglot'
    use 'jjo/vim-cue'
    use 'google/vim-jsonnet'
    use 'captbaritone/better-indent-support-for-php-with-html'
    use 'jparise/vim-graphql'

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
    use { 'hoob3rt/lualine.nvim', config = plugin_config('lualine') }
    use 'jpalardy/vim-slime' -- REPL
    use { 'dense-analysis/ale', config = plugin_config('ale') }
    use 'justinmk/vim-sneak'
    use 'junegunn/vim-easy-align'
    use 'airblade/vim-gitgutter'
    use 'kshenoy/vim-signature'
    use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
    use 'junegunn/fzf.vim'
    use 'Yggdroot/indentLine'
    use { 'norcalli/snippets.nvim', config = plugin_config('snippets') }
    use { 'neovim/nvim-lspconfig', config = plugin_config('lsp') }
    use 'rhysd/git-messenger.vim'
    use 'simnalamburt/vim-mundo'

    use { 'Shougo/deoplete.nvim', run = ':UpdateRemotePlugins' }
    use 'Shougo/deoplete-lsp'

    -- notes and text editing
    use 'lervag/wiki.vim'
    use 'fiatjaf/neuron.vim'
    use { 'junegunn/goyo.vim', cmd = 'Goyo' }
    use { 'alok/notational-fzf-vim', requires = 'junegunn/fzf.vim' }

    -- language specific
    use { 'vim-vdebug/vdebug', ft = 'php' }
    use { 'fatih/vim-go',      ft = 'go' }
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

    vim.g.wiki_root = '~/sync/0-essential/notes'
    vim.g.wiki_filetypes = { 'md' }

    vim.g.mundo_width = 100
    vim.g.mundo_right = 1
end
