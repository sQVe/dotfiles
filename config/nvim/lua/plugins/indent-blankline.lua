--  ╻┏┓╻╺┳┓┏━╸┏┓╻╺┳╸   ┏┓ ╻  ┏━┓┏┓╻╻┏ ╻  ╻┏┓╻┏━╸
--  ┃┃┗┫ ┃┃┣╸ ┃┗┫ ┃    ┣┻┓┃  ┣━┫┃┗┫┣┻┓┃  ┃┃┗┫┣╸
--  ╹╹ ╹╺┻┛┗━╸╹ ╹ ╹    ┗━┛┗━╸╹ ╹╹ ╹╹ ╹┗━╸╹╹ ╹┗━╸

return function()
  require('indent_blankline').setup({
    filetype_exclude = { 'alpha', 'help', 'packer' },
    buftype_exclude = { 'nofile', 'terminal' },
    show_current_context = true,
    show_first_indent_level = false,
    use_treesitter = true,
  })
end
