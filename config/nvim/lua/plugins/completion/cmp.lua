--  ┏━╸┏━┓┏┳┓┏━┓┏━╸
--  ┃  ┃ ┃┃┃┃┣━┛┣╸
--  ┗━╸┗━┛╹ ╹╹  ┗━╸
return function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')

    local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
            return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and
                   vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(
                       col, col):match('%s') == nil
    end

    local tab_complete = function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif has_words_before() then
            cmp.complete()
        else
            fallback()
        end
    end

    local s_tab_complete = function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        else
            fallback()
        end
    end

    local signature_help = function()
        if cmp.visible() then
            cmp.close()
        end
        vim.lsp.buf.signature_help()
    end

    local expand_snippet = function(args)
        vim.fn['vsnip#anonymous'](args.body)
    end

    local get_all_buffers = function() return vim.api.nvim_list_bufs() end

    cmp.setup {
        experimental = {ghost_text = {hl_group = 'GruvboxGray'}},
        formatting = {
            format = lspkind.cmp_format({
                with_text = false,
                menu = ({
                    buffer = ' buf',
                    nvim_lsp = ' lsp',
                    nvim_lua = ' api',
                    path = ' path',
                    vsnip = ' snip',
                }),
            }),
        },
        mapping = {
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-d>'] = cmp.mapping.scroll_docs(8),
            ['<C-e>'] = cmp.mapping.close(),
            ['<C-k>'] = cmp.mapping(signature_help, {'i', 's'}),
            ['<C-u>'] = cmp.mapping.scroll_docs(-8),
            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            }),
            ['<S-Tab>'] = cmp.mapping(s_tab_complete, {'i', 's'}),
            ['<Tab>'] = cmp.mapping(tab_complete, {'i', 's'}),
        },
        snippet = {expand = expand_snippet},
        sorting = {
            comparators = {
                cmp.config.compare.exact, cmp.config.compare.score,
                cmp.config.compare.offset, cmp.config.compare.length,
                cmp.config.compare.sort_text, cmp.config.compare.order,
            },
        },

        sources = {
            {name = 'nvim_lua', priority = 80},
            {name = 'nvim_lsp', priority = 60}, {name = 'path', priority = 40},
            {name = 'vsnip', keyword_length = 2, priority = 20}, {
                name = 'buffer',
                opts = {
                    get_bufnrs = get_all_buffers,
                    keyword_length = 4,
                    keyword_pattern = [[\k\+]], -- Include special characters in word match.
                },
                priority = 10,
            },
        },
    }
end
