-- ┏━╸╻ ╻┏━┓╺┳╸┏━┓┏┳┓   ╻ ╻╻┏━╸╻ ╻╻  ╻┏━╸╻ ╻╺┳╸┏━┓
-- ┃  ┃ ┃┗━┓ ┃ ┃ ┃┃┃┃   ┣━┫┃┃╺┓┣━┫┃  ┃┃╺┓┣━┫ ┃ ┗━┓
-- ┗━╸┗━┛┗━┛ ╹ ┗━┛╹ ╹   ╹ ╹╹┗━┛╹ ╹┗━╸╹┗━┛╹ ╹ ╹ ┗━┛

local colors = require('sQVe.plugins.catppuccin.palette').colors

return function(theme)
  return {
    -- Syntax.
    Boolean = { fg = theme.mauve },
    ColorColumn = { bg = theme.base },
    CurSearch = { bg = theme.maroon, bold = true },
    CursorLine = { bg = colors.gruvbox.dark0_soft },
    CursorLineFold = { bg = colors.gruvbox.dark0_soft },
    CursorLineNr = { fg = theme.yellow, bg = colors.gruvbox.dark0_soft },
    CursorLineSign = { bg = colors.gruvbox.dark0_soft },
    Folded = { fg = theme.overlay1, bg = theme.surface0 },
    IncSearch = { fg = theme.base, bg = theme.yellow, bold = true },
    Include = { fg = theme.teal },
    Keyword = { fg = theme.red },
    Number = { fg = theme.mauve },
    Operator = { fg = theme.text },
    Search = { fg = theme.base, bg = theme.yellow },
    Special = { fg = theme.subtext0 },

    -- Copilot.
    CopilotSuggestion = { fg = colors.custom.steel, italic = true },

    -- Flash.
    FlashLabel = { fg = colors.gruvbox.light0, bold = true },
    FlashCurrent = { fg = theme.maroon },
    FlashMatch = { fg = theme.yellow },

    -- Headlines.
    Headline1 = { bg = theme.surface0, bold = true },
    Headline2 = { bg = theme.surface0, bold = true },
    Headline3 = { bg = theme.surface0, bold = true },
    Headline4 = { bg = theme.surface0, bold = true },
    Headline5 = { bg = theme.surface0, bold = true },
    Headline6 = { bg = theme.surface0, bold = true },

    -- Illuminate.
    IlluminatedWordRead = { bg = theme.none, underline = true },
    IlluminatedWordText = { bg = theme.none, underline = true },
    IlluminatedWordWrite = { bg = theme.none, underline = true },

    -- LSP.
    LspCodeLens = { fg = theme.surface2, italic = true },

    -- Mini diff.
    MiniDiffSignAdd = { fg = theme.green },
    MiniDiffSignChange = { fg = theme.yellow },
    MiniDiffSignDelete = { fg = theme.red },

    -- Mini hipatterns.
    MiniHipatternsDone = {
      bg = theme.green,
      fg = theme.base,
      bold = true,
    },
    MiniHipatternsFixme = {
      bg = theme.red,
      fg = theme.base,
      bold = true,
    },
    MiniHipatternsHack = {
      bg = theme.maroon,
      fg = theme.base,
      bold = true,
    },
    MiniHipatternsNote = {
      bg = theme.teal,
      fg = theme.base,
      bold = true,
    },
    MiniHipatternsTodo = {
      bg = theme.yellow,
      fg = theme.base,
      bold = true,
    },

    -- Telescope.
    TelescopeBorder = { fg = theme.surface0 },
    TelescopePreviewBorder = {
      fg = theme.surface0,
      bg = theme.base,
      italic = true,
    },
    TelescopePromptBorder = {
      fg = theme.overlay0,
      bg = theme.base,
      bold = true,
    },
    TelescopeTitle = { fg = theme.subtext0 },
    TelescopePromptTitle = { fg = theme.yellow },

    -- Treesitter.
    ['@function.macro.luadoc'] = { link = 'Macro' },
    ['@heading.marker'] = { bold = true },
    ['@keyword.export'] = { fg = theme.teal },
    ['@keyword.function'] = { fg = theme.red, bold = true },
    ['@keyword.return'] = { fg = theme.red },
    ['@lsp.type.class.markdown'] = { fg = theme.yellow },
    ['@lsp.type.decorator.markdown'] = {},
    ['@lsp.type.interface'] = { link = 'Type' },
    ['@markup.link.label.markdown_inline'] = { fg = theme.yellow },
    ['@markup.link.markdown_inline'] = { fg = theme.text },
    ['@markup.link.url.markdown_inline'] = {
      fg = theme.text,
      underline = true,
    },

    ['@parameter'] = { fg = theme.peach },
    ['@tag.delimiter'] = { fg = theme.subtext0 },
    ['@text.todo.checked'] = { fg = theme.green },
    ['@text.todo.checked.text'] = { fg = theme.overlay1 },
    ['@text.todo.unchecked'] = { fg = theme.red },
    ['@text.todo.unchecked.text'] = { fg = theme.text },
    ['@variable.parameter'] = { fg = theme.peach },

    -- Treesitter context.
    TreesitterContext = { bg = colors.custom.inset },
    TreesitterContextLineNumber = { bg = colors.custom.inset },
  }
end
