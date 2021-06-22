--  ┏━┓┏━┓┏━┓╺┳╸┏━╸┏━┓
--  ┣┳┛┃ ┃┃ ┃ ┃ ┣╸ ┣┳┛
--  ╹┗╸┗━┛┗━┛ ╹ ┗━╸╹┗╸
return function()
    vim.g.rooter_manual_only = 1
    vim.g.rooter_patterns = {'.editorconfig', '.env', '.git'}
    vim.g.rooter_resolve_links = 1
    vim.g.rooter_targets = '*'
end
