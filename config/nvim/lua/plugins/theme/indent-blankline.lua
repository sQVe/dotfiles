--  ╻┏┓╻╺┳┓┏━╸┏┓╻╺┳╸   ┏┓ ╻  ┏━┓┏┓╻╻┏ ╻  ╻┏┓╻┏━╸
--  ┃┃┗┫ ┃┃┣╸ ┃┗┫ ┃    ┣┻┓┃  ┣━┫┃┗┫┣┻┓┃  ┃┃┗┫┣╸
--  ╹╹ ╹╺┻┛┗━╸╹ ╹ ╹    ┗━┛┗━╸╹ ╹╹ ╹╹ ╹┗━╸╹╹ ╹┗━╸
return function()
    vim.g.indent_blankline_char = "│"
    vim.g.indent_blankline_filetype_exclude = {"dashboard", "help", "packer"}
    vim.g.indent_blankline_show_current_context = true
    vim.g.indent_blankline_show_first_indent_level = false
    vim.g.indent_blankline_use_treesitter = true

    -- LuaFormatter off
    vim.g.indent_blankline_context_patterns = {
        -- JavaScript and TypeScript
        "declaration",
        "expression",
        "pattern",
        "statement",
        "switch_body",

        -- Bash and Go.
        "_expression",
        "_simple_statement",
        "_simple_type",
        "_statement",
        "_type",

        -- General.
        "class",
        "function",
        "method",
    }
    -- LuaFormatter on
end
