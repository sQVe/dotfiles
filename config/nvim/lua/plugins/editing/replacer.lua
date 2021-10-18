-- ┏━┓┏━╸┏━┓╻  ┏━┓┏━╸┏━╸┏━┓
-- ┣┳┛┣╸ ┣━┛┃  ┣━┫┃  ┣╸ ┣┳┛
-- ╹┗╸┗━╸╹  ┗━╸╹ ╹┗━╸┗━╸╹┗╸
return function()
    vim.cmd([[
        command! Replace lua require("replacer").run()<CR>
    ]])
end
