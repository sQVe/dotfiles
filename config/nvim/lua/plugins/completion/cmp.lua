--  ┏━╸┏━┓┏┳┓┏━┓┏━╸
--  ┃  ┃ ┃┃┃┃┣━┛┣╸
--  ┗━╸┗━┛╹ ╹╹  ┗━╸
return function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')

    local config = cmp.config
    local mapping = cmp.mapping

    -- Pattern that matches any consecutive characters, including special ones.
    local anyWord = [[\k\+]]

    local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
            return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and
                   vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(
                       col, col):match('%s') == nil
    end

    local mapKey = function(keyMap) return mapping(keyMap, {'c', 'i'}) end

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
            ['<C-Space>'] = mapKey(mapping.complete()),
            ['<C-d>'] = mapKey(mapping.scroll_docs(8)),
            ['<C-e>'] = mapKey(mapping.close()),
            ['<C-k>'] = mapKey(signature_help),
            ['<C-u>'] = mapKey(mapping.scroll_docs(-8)),
            ['<CR>'] = mapKey(mapping.confirm({select = false})),
            ['<S-Tab>'] = mapKey(s_tab_complete),
            ['<Tab>'] = mapKey(tab_complete),
        },
        snippet = {expand = expand_snippet},
        sorting = {
            comparators = {
                config.compare.offset, config.compare.exact,
                config.compare.score, config.compare.recently_used,
                config.compare.length, config.compare.sort_text,
                config.compare.order,
            },
        },
        sources = config.sources({
            {name = 'nvim_lua', priority = 80},
            {name = 'nvim_lsp', priority = 80}, {name = 'path', priority = 40},
            {name = 'vsnip', keyword_length = 2, priority = 20}, {
                name = 'buffer',
                keyword_length = 4,
                opts = {get_bufnrs = get_all_buffers, keyword_pattern = anyWord},
                priority = 10,
            },
        }),
    }

    local searchSources = {
        sources = config.sources({
            {
                name = 'buffer',
                keyword_length = 2,
                opts = {keyword_pattern = anyWord},
            },
        }),
    }
    cmp.setup.cmdline('/', searchSources)
    cmp.setup.cmdline('?', searchSources)
    cmp.setup.cmdline(':', {
        sources = config.sources({
            {name = 'cmdline', priority = 40}, {
                name = 'buffer',
                keyword_length = 2,
                opts = {keyword_pattern = anyWord},
                priority = 10,
            },
        }),
    })
end
