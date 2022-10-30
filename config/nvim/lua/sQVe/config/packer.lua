-- ╻┏┓╻╻╺┳╸
-- ┃┃┗┫┃ ┃
-- ╹╹ ╹╹ ╹

-- Add builtin plugins.
vim.cmd('packadd cfilter')

local customized_plugins = {
  'alpha',
  'bbye',
  'cmp',
  'comment',
  'dap',
  'fidget',
  'focus',
  'fugitive',
  'gitsigns',
  'gruvbox',
  'illuminate',
  'indent-blankline',
  'leap',
  'lsp',
  'lualine',
  'null-ls',
  'pasta',
  'project',
  'rust-tools',
  'sort',
  'surround',
  'telescope',
  'treesitter',
  'typescript',
  'vsnip',
}

return require('packer').startup({
  function(use)
    -- Handle packer with packer.
    use({ 'wbthomason/packer.nvim', opt = true })

    -- Optimize startup.
    use({ 'lewis6991/impatient.nvim' })

    -- Dependencies.
    use({ 'tpope/vim-repeat', event = 'BufEnter' }) -- Repeat support.
    use({ 'nvim-lua/plenary.nvim', module = 'plenary' }) -- Lua utilities.

    -- Editorconfig.
    use({ 'gpanders/editorconfig.nvim', event = 'BufEnter' })

    -- Improved f, F, t, and T motions.
    use({
      'ggandor/flit.nvim',
      after = 'leap.nvim',
      config = function()
        require('flit').setup()
      end,
    })

    -- Complete pairs.
    use({
      'windwp/nvim-autopairs',
      event = { 'InsertEnter' },
      config = function()
        require('nvim-autopairs').setup()
      end,
    })

    -- Interactive registers.
    use({
      'tversteeg/registers.nvim',
      cmd = { 'Registers' },
      config = function()
        require('registers').setup()
      end,
      keys = {
        { 'i', '<c-r>' },
        { 'n', '"' },
        { 'v', '"' },
      },
    })

    -- Git mergetool.
    use({
      'whiteinge/diffconflicts',
      cmd = {
        'DiffConflicts',
        'DiffConflictsShowHistory',
        'DiffConflictsWithHistory ',
      },
    })

    -- Complete pairs.
    use({
      'windwp/nvim-autopairs',
      event = { 'InsertEnter' },
      config = function()
        require('nvim-autopairs').setup()
      end,
    })

    -- Text objects.
    use({ 'RRethy/nvim-treesitter-textsubjects', after = 'nvim-treesitter' }) -- Smart selection.
    use({ 'michaeljsmith/vim-indent-object', event = 'CursorMoved' }) -- Indent text object.
    use({ 'wellle/targets.vim', event = 'CursorMoved' }) -- Additional text objects.

    -- Initialize all customized plugins.
    for _, customized_plugin in ipairs(customized_plugins) do
      require('sQVe.plugins.' .. customized_plugin).init(use)
    end
  end,
})
