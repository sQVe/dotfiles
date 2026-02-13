-- ┏━╸╻ ╻┏━┓╺┳╸┏━┓┏┳┓   ╻ ╻╻┏━╸╻ ╻╻  ╻┏━╸╻ ╻╺┳╸┏━┓
-- ┃  ┃ ┃┗━┓ ┃ ┃ ┃┃┃┃   ┣━┫┃┃╺┓┣━┫┃  ┃┃╺┓┣━┫ ┃ ┗━┓
-- ┗━╸┗━┛┗━┛ ╹ ┗━┛╹ ╹   ╹ ╹╹┗━┛╹ ╹┗━╸╹┗━┛╹ ╹ ╹ ┗━┛

return function(theme)
  local U = require('catppuccin.utils.colors')

  return {
    -- Color and cursor line.
    ColorColumn = { bg = theme.base },
    CursorLine = { bg = theme.mantle },
    CursorLineFold = { bg = theme.mantle },
    CursorLineNr = { bg = theme.mantle },

    -- Search.
    CurSearch = { bg = theme.teal, bold = true },

    -- Chainsaw.
    ChainsawLog = { bg = theme.crust },

    DiffAdd = { bg = U.darken(theme.green, 0.05, theme.base) },
    DiffChange = { bg = U.darken(theme.blue, 0.05, theme.base) },
    DiffDelete = { bg = U.darken(theme.red, 0.05, theme.base) },
    DiffText = { bg = U.darken(theme.blue, 0.1, theme.base) },

    -- Gitsigns.
    GitSignsAdd = { fg = theme.mauve },
    GitSignsChange = { fg = theme.teal },
    GitSignsDelete = { fg = theme.red },

    -- Flash.
    FlashCurrent = { fg = theme.subtext1, bg = 'none', bold = true },
    FlashLabel = { fg = theme.base, bg = theme.text, bold = true },
    FlashMatch = { fg = theme.subtext0, bg = 'none' },

    -- Hipatterns.
    MiniHipatternsDone = { fg = theme.base, bg = theme.green, bold = true },
    MiniHipatternsFixme = { fg = theme.base, bg = theme.red, bold = true },
    MiniHipatternsHack = { fg = theme.base, bg = theme.maroon, bold = true },
    MiniHipatternsNote = { fg = theme.base, bg = theme.teal, bold = true },
    MiniHipatternsTodo = { fg = theme.base, bg = theme.yellow, bold = true },

    -- Snacks.
    SnacksDashboardDesc = { fg = theme.text },
    SnacksDashboardFooter = { fg = theme.text },
    SnacksDashboardHeader = { fg = theme.text },
    SnacksDashboardIcon = { fg = theme.text },
    SnacksDashboardKey = { fg = theme.text },
    SnacksIndent = { fg = theme.mantle },
    SnacksIndentScope = { fg = theme.surface0 },
    SnacksPickerListCursorLine = { bg = theme.crust },
  }
end
