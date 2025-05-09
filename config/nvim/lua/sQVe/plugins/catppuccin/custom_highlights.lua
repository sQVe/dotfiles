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
    CursorLine = { bg = theme.mantle },
    CursorLineFold = { bg = theme.mantle },
    CursorLineNr = { fg = theme.yellow, bg = theme.mantle },
    CursorLineSign = { bg = theme.mantle },
    Folded = { fg = theme.overlay1, bg = theme.surface0 },
    IncSearch = { fg = theme.base, bg = theme.yellow, bold = true },
    Include = { fg = theme.teal },
    Keyword = { fg = theme.red },
    Number = { fg = theme.mauve },
    Operator = { fg = theme.text },
    Search = { fg = theme.base, bg = theme.yellow },
    Special = { fg = theme.subtext0 },

    -- Chainsaw.
    ChainsawLog = { bg = colors.custom.fade },

    -- Flash.
    FlashLabel = { fg = theme.yellow, bg = 'none', bold = true },
    FlashCurrent = { fg = theme.subtext1, bg = 'none', bold = true },
    FlashMatch = { fg = theme.subtext0, bg = 'none' },

    -- Illuminate.
    IlluminatedWordRead = { bg = theme.none, underline = true },
    IlluminatedWordText = { bg = theme.none, underline = true },
    IlluminatedWordWrite = { bg = theme.none, underline = true },

    -- Input.
    InputBorder = { fg = theme.crust, bg = theme.crust },
    InputNormal = { fg = theme.text, bg = theme.crust },
    InputTitle = { fg = theme.crust, bg = theme.peach, bold = true },

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

    -- Snacks.
    SnacksIndent = { fg = theme.surface0 },
    SnacksIndentScope = { fg = theme.surface1 },
    SnacksDashboardHeader = { fg = theme.surface1 },
    SnacksDashboardDesc = { fg = theme.overlay1 },

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
  }
end
