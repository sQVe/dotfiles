-- ╻┏┓╻╺┳╸┏━╸┏━╸┏━┓┏━┓╺┳╸╻┏━┓┏┓╻┏━┓
-- ┃┃┗┫ ┃ ┣╸ ┃╺┓┣┳┛┣━┫ ┃ ┃┃ ┃┃┗┫┗━┓
-- ╹╹ ╹ ╹ ┗━╸┗━┛╹┗╸╹ ╹ ╹ ╹┗━┛╹ ╹┗━┛

return {
  blink_cmp = true,
  fidget = true,
  flash = true,
  gitsigns = true,
  grug_far = true,
  lualine = {
    all = function(C)
      return {
        normal = { c = { bg = C.mantle, fg = C.text } },
        insert = { c = { bg = C.mantle, fg = C.text } },
        visual = { c = { bg = C.mantle, fg = C.text } },
        replace = { c = { bg = C.mantle, fg = C.text } },
        command = { c = { bg = C.mantle, fg = C.text } },
        terminal = { c = { bg = C.mantle, fg = C.text } },
        inactive = { c = { bg = C.mantle, fg = C.overlay0 } },
      }
    end,
  },
  mini = { enabled = true, indentscope_color = '' },
  snacks = true,
  which_key = true,
}
