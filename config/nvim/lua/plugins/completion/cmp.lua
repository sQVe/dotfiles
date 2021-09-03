--  ┏━╸┏━┓┏┳┓┏━┓┏━╸
--  ┃  ┃ ┃┃┃┃┣━┛┣╸
--  ┗━╸┗━┛╹ ╹╹  ┗━╸
return function()
    local cmp = require('cmp')

    local check_back_space = function()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
    end

    local T = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    local tab_complete = function(fallback)
        if vim.fn.pumvisible() == 1 then
            vim.fn.feedkeys(T('<C-n>'), 'n')
        elseif vim.fn['vsnip#available'](1) == 1 then
            vim.fn.feedkeys(T('<Plug>(vsnip-expand-or-jump)'), '')
        elseif check_back_space() then
            vim.fn.feedkeys(T('<Tab>'), 'n')
        else
            fallback()
        end
    end

    local s_tab_complete = function(fallback)
        if vim.fn.pumvisible() == 1 then
            vim.fn.feedkeys(('<C-p>'), 'n')
        elseif vim.fn['vsnip#jumpable'](-1) == 1 then
            vim.fn.feedkeys(T('<Plug>(vsnip-jump-prev)'), '')
        else
            fallback()
        end
    end

    local expand_snippet = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end

    cmp.setup {
        snippet = {expand = expand_snippet},
        mapping = {
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true
            }),
            ['<S-Tab>'] = cmp.mapping(s_tab_complete, {"i", "s"}),
            ['<Tab>'] = cmp.mapping(tab_complete, {"i", "s"})
        },
        sources = {
            {
                name = 'buffer',
                opts = {
                    get_bufnrs = function()
                        -- Get words for all buffers.
                        return vim.api.nvim_list_bufs()
                    end,
                    keyword_pattern = [[\k\+]]
                } -- Include special characters in word match.

            }, {name = 'path'}, {name = 'nvim_lsp'}, {name = 'vsnip'}
        }
    }
end
