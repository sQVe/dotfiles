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

    local expand_snippet = function(args)
        vim.fn['vsnip#anonymous'](args.body)
    end

    local get_all_buffers = function() return vim.api.nvim_list_bufs() end

    cmp.setup {
        experimental = {ghost_text = {hl_group = 'GruvboxGray'}},
        formatting = {format = lspkind.cmp_format({with_text = false})},
        mapping = {
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
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
            {name = 'nvim_lsp', priority = 100}, {name = 'path', priority = 80},
            {name = 'vsnip', keyword_length = 2, priority = 40}, {
                name = 'buffer',
                opts = {
                    get_bufnrs = get_all_buffers,
                    keyword_pattern = [[\k\+]], -- Include special characters in word match.
                },
                priority = 10,
            },
        },
    }
end
