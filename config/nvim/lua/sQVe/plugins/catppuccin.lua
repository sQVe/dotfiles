-- ┏━╸┏━┓╺┳╸┏━┓┏━┓╻ ╻┏━╸┏━╸╻┏┓╻
-- ┃  ┣━┫ ┃ ┣━┛┣━┛┃ ┃┃  ┃  ┃┃┗┫
-- ┗━╸╹ ╹ ╹ ╹  ╹  ┗━┛┗━╸┗━╸╹╹ ╹
-- Catppuccin color scheme, heavily customized with gruvbox colors.

-- stylua: ignore
local palette = {
  custom = {
    inset = "#242424"
  },
  mocha = {
    blue      = "#89B4FA",
    flamingo  = "#F2CDCD",
    green     = "#A6E3A1",
    lavender  = "#B4BEFE",
    maroon    = "#EBA0AC",
    mauve     = "#CBA6F7",
    peach     = "#FAB387",
    pink      = "#F5C2E7",
    red       = "#F38BA8",
    rosewater = "#F5E0DC",
    sapphire  = "#74C7EC",
    sky       = "#89DCEB",
    teal      = "#94E2D5",
    yellow    = "#F9E2AF",
  },
  gruvbox = {
    bright_aqua    = '#8EC07C',
    bright_blue    = '#83A598',
    bright_green   = '#B8BB26',
    bright_orange  = '#FE8019',
    bright_purple  = '#D3869B',
    bright_red     = '#FB4934',
    bright_yellow  = '#FABD2F',
    dark0          = '#282828',
    dark0_hard     = '#1D2021',
    dark0_soft     = '#32302F',
    dark1          = '#3C3836',
    dark2          = '#504945',
    dark3          = '#665C54',
    dark4          = '#7C6F64',
    faded_aqua     = '#427B58',
    faded_blue     = '#076678',
    faded_green    = '#79740E',
    faded_orange   = '#AF3A03',
    faded_purple   = '#8F3F71',
    faded_red      = '#9D0006',
    faded_yellow   = '#B57614',
    gray           = '#928374',
    light0         = '#FBF1C7',
    light0_hard    = '#F9F5D7',
    light0_soft    = '#F2E5BC',
    light1         = '#EBDBB2',
    light2         = '#D5C4A1',
    light3         = '#BDAE93',
    light4         = '#A89984',
    neutral_aqua   = '#689D6A',
    neutral_blue   = '#458588',
    neutral_green  = '#98971A',
    neutral_orange = '#D65D0E',
    neutral_purple = '#B16286',
    neutral_red    = '#CC241D',
    neutral_yellow = '#D79921',
  },
}

local M = {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
}

M.opts = function()
  local color_overrides = {
    all = {
      -- Colors.
      blue = palette.gruvbox.bright_blue,
      flamingo = palette.mocha.flamingo,
      green = palette.gruvbox.bright_green,
      lavender = palette.gruvbox.light2,
      maroon = palette.gruvbox.bright_orange,
      mauve = palette.gruvbox.bright_purple,
      peach = palette.mocha.peach,
      pink = palette.mocha.flamingo,
      red = palette.gruvbox.bright_red,
      rosewater = palette.gruvbox.light2,
      sapphire = palette.mocha.sapphire,
      sky = palette.gruvbox.bright_aqua,
      teal = palette.mocha.teal,
      yellow = palette.gruvbox.bright_yellow,

      -- Shades.
      text = palette.gruvbox.light1,
      subtext1 = palette.gruvbox.light2,
      subtext0 = palette.gruvbox.light3,
      overlay2 = palette.gruvbox.light4,
      overlay1 = palette.gruvbox.gray,
      overlay0 = palette.gruvbox.dark4,
      surface2 = palette.gruvbox.dark3,
      surface1 = palette.gruvbox.dark2,
      surface0 = palette.gruvbox.dark1,
      base = palette.gruvbox.dark0,
      mantle = palette.gruvbox.dark0_soft,
      crust = palette.gruvbox.dark0_hard,
    },
  }

  local custom_highlights = function(colors)
    return {
      -- Syntax.
      Boolean = { fg = colors.mauve },
      ColorColumn = { bg = colors.base },
      CurSearch = { bg = colors.maroon, bold = true },
      CursorLine = { bg = palette.gruvbox.dark0_soft },
      CursorLineFold = { bg = palette.gruvbox.dark0_soft },
      CursorLineNr = { fg = colors.yellow, bg = palette.gruvbox.dark0_soft },
      CursorLineSign = { bg = palette.gruvbox.dark0_soft },
      Folded = { fg = colors.overlay1, bg = colors.surface0 },
      IncSearch = { fg = colors.base, bg = colors.yellow, bold = true },
      Include = { fg = colors.sky },
      Keyword = { fg = colors.red },
      Number = { fg = colors.mauve },
      Operator = { fg = colors.text },
      Search = { fg = colors.base, bg = colors.yellow },
      Special = { fg = colors.subtext0 },

      -- Diagnostic.
      DiagnosticFloatingHint = { fg = colors.subtext0 },
      DiagnosticSignHint = { fg = colors.overlay0 },

      -- Flash.
      FlashLabel = { fg = palette.gruvbox.light0, bold = true },
      FlashCurrent = { fg = colors.maroon },
      FlashMatch = { fg = colors.yellow },

      -- Gp.
      GpHandlerStandout = { bg = colors.base },

      -- Headlines.
      Headline1 = { bg = colors.surface0, bold = true },
      Headline2 = { bg = colors.surface0, bold = true },
      Headline3 = { bg = colors.surface0, bold = true },
      Headline4 = { bg = colors.surface0, bold = true },
      Headline5 = { bg = colors.surface0, bold = true },
      Headline6 = { bg = colors.surface0, bold = true },

      -- Illuminate.
      IlluminatedWordRead = { bg = colors.none, underline = true },
      IlluminatedWordText = { bg = colors.none, underline = true },
      IlluminatedWordWrite = { bg = colors.none, underline = true },

      -- Mini hipatterns.
      MiniHipatternsFixme = {
        bg = colors.red,
        fg = colors.base,
        bold = true,
      },
      MiniHipatternsHack = {
        bg = colors.yellow,
        fg = colors.base,
        bold = true,
      },
      MiniHipatternsTodo = {
        bg = colors.yellow,
        fg = colors.base,
        bold = true,
      },
      MiniHipatternsNote = {
        bg = colors.sky,
        fg = colors.base,
        bold = true,
      },

      -- Telescope.
      TelescopeBorder = { fg = colors.surface0 },
      TelescopePreviewBorder = {
        fg = colors.surface0,
        bg = colors.base,
        italic = true,
      },
      TelescopePromptBorder = {
        fg = colors.overlay0,
        bg = colors.base,
        bold = true,
      },
      TelescopeTitle = { fg = colors.subtext0 },
      TelescopePromptTitle = { fg = colors.yellow },

      -- Treesitter.
      ['@function.macro.luadoc'] = { link = 'Macro' },
      ['@heading.marker'] = { bold = true },
      ['@keyword.export'] = { fg = colors.sky },
      ['@keyword.function'] = { fg = colors.red, bold = true },
      ['@keyword.return'] = { fg = colors.red },
      ['@lsp.type.interface'] = { link = 'Type' },
      ['@parameter'] = { fg = colors.peach },
      ['@tag.delimiter'] = { fg = colors.subtext0 },
      ['@text.todo.checked'] = { fg = colors.green },
      ['@text.todo.checked.text'] = { fg = colors.overlay1 },
      ['@text.todo.unchecked'] = { fg = colors.red },
      ['@text.todo.unchecked.text'] = { fg = colors.text },
      ['@variable.parameter'] = { fg = colors.peach },

      -- Treesitter context.
      TreesitterContext = { bg = palette.custom.inset },
      TreesitterContextLineNumber = { bg = palette.custom.inset },
    }
  end

  local integrations = {
    alpha = true,
    barbecue = false,
    cmp = true,
    dap = false,
    dap_ui = false,
    dashboard = false,
    fidget = true,
    flash = true,
    gitsigns = true,
    headlines = true,
    illuminate = { enabled = true },
    indent_blankline = { enabled = true, scope_color = '' },
    markdown = true,
    mini = { enabled = true, indentscope_color = '' },
    native_lsp = {
      enabled = true,
      underlines = {
        errors = { 'undercurl' },
        hints = { 'underline' },
        warnings = { 'undercurl' },
        information = { 'underline' },
      },
    },
    neogit = false,
    nvimtree = false,
    rainbow_delimiters = false,
    semantic_tokens = true,
    telescope = { enabled = true },
    treesitter = true,
    treesitter_context = true,
    which_key = true,
  }

  local styles = {
    booleans = { 'bold' },
    comments = { 'italic' },
    conditionals = { 'italic' },
    functions = {},
    keywords = {},
    loops = {},
    numbers = {},
    operators = {},
    properties = {},
    strings = { 'italic' },
    types = {},
    variables = {},
  }

  return {
    compile_path = vim.fn.expand('$PERSISTENT_CACHE') .. '/catppuccin',
    color_overrides = color_overrides,
    custom_highlights = custom_highlights,
    integrations = integrations,
    styles = styles,
  }
end

M.config = function(_, opts)
  require('catppuccin').setup(opts)

  -- Set diagnostic signs.
  vim.fn.sign_define(
    'DiagnosticSignError',
    { text = '', texthl = 'DiagnosticSignError' }
  )
  vim.fn.sign_define(
    'DiagnosticSignHint',
    { text = '', texthl = 'DiagnosticSignHint' }
  )
  vim.fn.sign_define(
    'DiagnosticSignInfo',
    { text = '', texthl = 'DiagnosticSignInfo' }
  )
  vim.fn.sign_define(
    'DiagnosticSignWarn',
    { text = '', texthl = 'DiagnosticSignWarn' }
  )

  vim.o.background = 'dark'
  vim.cmd.colorscheme('catppuccin')
end

return M
