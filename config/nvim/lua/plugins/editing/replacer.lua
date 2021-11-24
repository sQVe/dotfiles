-- ┏━┓┏━╸┏━┓╻  ┏━┓┏━╸┏━╸┏━┓
-- ┣┳┛┣╸ ┣━┛┃  ┣━┫┃  ┣╸ ┣┳┛
-- ╹┗╸┗━╸╹  ┗━╸╹ ╹┗━╸┗━╸╹┗╸
return function()
  vim.cmd([[
    command! Replace lua require("replacer").run()<CR>
    command! ReplaceContent lua require("replacer").run({ rename_files = false })<CR>
  ]])
end
