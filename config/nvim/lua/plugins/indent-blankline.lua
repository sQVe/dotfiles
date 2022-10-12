--  ╻┏┓╻╺┳┓┏━╸┏┓╻╺┳╸   ┏┓ ╻  ┏━┓┏┓╻╻┏ ╻  ╻┏┓╻┏━╸
--  ┃┃┗┫ ┃┃┣╸ ┃┗┫ ┃    ┣┻┓┃  ┣━┫┃┗┫┣┻┓┃  ┃┃┗┫┣╸
--  ╹╹ ╹╺┻┛┗━╸╹ ╹ ╹    ┗━┛┗━╸╹ ╹╹ ╹╹ ╹┗━╸╹╹ ╹┗━╸

return function()
  require('indent_blankline').setup({
    filetype_exclude = { 'alpha', 'help', 'packer' },
    buftype_exclude = { 'nofile', 'terminal' },
    show_current_context = true,
    use_treesitter = true,
  })
end
