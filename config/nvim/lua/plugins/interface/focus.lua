--  ┏━╸┏━┓┏━╸╻ ╻┏━┓
--  ┣╸ ┃ ┃┃  ┃ ┃┗━┓
--  ╹  ┗━┛┗━╸┗━┛┗━┛
return function()
    require('focus').setup({
        excluded_filetypes = { 'fugitiveblame', 'harpoon' },
        number = false,
        signcolumn = false,
    })
end
