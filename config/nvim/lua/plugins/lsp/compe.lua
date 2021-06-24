--  ┏━╸┏━┓┏┳┓┏━┓┏━╸
--  ┃  ┃ ┃┃┃┃┣━┛┣╸
--  ┗━╸┗━┛╹ ╹╹  ┗━╸
return function()
    require'compe'.setup {
        source = {
            buffer = true,
            calc = false,
            nvim_lsp = true,
            nvim_lua = true,
            path = true,
            spell = true,
            ultisnips = false,
            vsnip = true
        }
    }

    local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    local check_back_space = function()
        local col = vim.fn.col('.') - 1
        if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
            return true
        else
            return false
        end
    end

    _G.tab_complete = function()
        if vim.fn.pumvisible() == 1 then
            return t "<C-n>"
        elseif vim.fn.call("vsnip#available", {1}) == 1 then
            return t "<Plug>(vsnip-expand-or-jump)"
        elseif check_back_space() then
            return t "<Tab>"
        else
            return vim.fn['compe#complete']()
        end
    end
    _G.s_tab_complete = function()
        if vim.fn.pumvisible() == 1 then
            return t "<C-p>"
        elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
            return t "<Plug>(vsnip-jump-prev)"
        else
            return t "<S-Tab>"
        end
    end
    -- General keymap.
    vim.cmd([[
      inoremap <silent><expr> <C-Space> compe#complete()
      inoremap <silent><expr> <CR> compe#confirm('<CR>')
      inoremap <silent><expr> <C-e> compe#close('<C-e>')
    ]])

    -- Handle completion with Tab and S-Tab.
    vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()",
                            {expr = true, silent = true})
    vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()",
                            {expr = true, silent = true})
    vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()",
                            {expr = true, silent = true})
    vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()",
                            {expr = true, silent = true})
end
