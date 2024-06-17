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

    -- Input.
    InputBorder = { fg = colors.custom.inset, bg = colors.custom.inset },
    InputNormat = { fg = theme.text, bg = colors.custom.inset },
    InputTitle = { fg = colors.custom.inset, bg = theme.peach, bold = true },

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

    -- Smart open.
    Directory = { fg = theme.overlay2 },

    -- Telescope.
    TelescopeNormal = { fg = theme.purple, bg = theme.mantle },
    TelescopeBorder = { fg = theme.mantle, bg = theme.mantle },
    TelescopeTitle = { fg = theme.mantle, bg = theme.mantle },
    TelescopeResultsNormal = { fg = theme.text, bg = theme.mantle },
    TelescopeSelection = { fg = theme.text, bg = theme.surface0 },
    TelescopeSelectionCaret = { fg = theme.yellow, bg = 'NONE' },
    TelescopeMultiSelection = { fg = theme.pink, bg = 'NONE' },
    TelescopeMatching = { fg = theme.blue },
    TelescopePromptNormal = { fg = theme.text, bg = colors.custom.inset },
    TelescopePromptBorder = {
      fg = colors.custom.inset,
      bg = colors.custom.inset,
    },
    TelescopePromptTitle = {
      fg = colors.custom.inset,
      bg = theme.peach,
      bold = true,
    },
    TelescopePreviewTitle = { fg = theme.overlay2, italic = true },

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
