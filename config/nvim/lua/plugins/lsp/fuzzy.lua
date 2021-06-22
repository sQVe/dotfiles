--  ┏━╸╻ ╻╺━┓╺━┓╻ ╻
--  ┣╸ ┃ ┃┏━┛┏━┛┗┳┛
--  ╹  ┗━┛┗━╸┗━╸ ╹
return function()
    require('lspfuzzy').setup {
        fzf_preview = {'down:+{2}-/2'},
        fzf_action = {
            ['ctrl-t'] = 'tabedit',
            ['ctrl-v'] = 'vsplit',
            ['ctrl-s'] = 'split'
        }
    }
end
