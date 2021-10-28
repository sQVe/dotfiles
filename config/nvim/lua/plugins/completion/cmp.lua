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

    local mapKey = function(keyMap) return cmp.mapping(keyMap, {'c', 'i'}) end

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
            ['<C-Space>'] = mapKey(cmp.mapping.complete()),
            ['<C-d>'] = mapKey(cmp.mapping.scroll_docs(8)),
            ['<C-e>'] = mapKey(cmp.mapping.close()),
            ['<C-k>'] = mapKey(signature_help),
            ['<C-u>'] = mapKey(cmp.mapping.scroll_docs(-8)),
            ['<CR>'] = mapKey(cmp.mapping.confirm({select = false})),
            ['<S-Tab>'] = mapKey(s_tab_complete),
            ['<Tab>'] = mapKey(tab_complete),
        },
        snippet = {expand = expand_snippet},
        sorting = {
            comparators = {
                cmp.config.compare.exact, cmp.config.compare.score,
                cmp.config.compare.offset, cmp.config.compare.length,
                cmp.config.compare.sort_text, cmp.config.compare.order,
            },
        },

        sources = cmp.config.sources({
            {name = 'nvim_lua'}, {name = 'nvim_lsp'}, {name = 'path'},
            {name = 'vsnip', keyword_length = 2}, {
                name = 'buffer',
                keyword_length = 4,
                keyword_pattern = [[\k\+]], -- Include special characters in word match.
                opts = {get_bufnrs = get_all_buffers},
            },
        }),
    }

    local searchKeys = {'/', '?', '%'}
    local searchSettings = {
        sources = {
            name = 'buffer',
            keyword_length = 2,
            keyword_pattern = [[\k\+]], -- Include special characters in word match.
        },
    }
    for _, searchKey in ipairs(searchKeys) do
        cmp.setup.cmdline(searchKey, cmp.config.sources(searchSettings))
    end

    cmp.setup.cmdline(':', {sources = cmp.config.sources({{name = 'cmdline'}})})
end
