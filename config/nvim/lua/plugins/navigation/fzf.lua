--  ┏━╸╺━┓┏━╸
--  ┣╸ ┏━┛┣╸
--  ╹  ┗━╸╹
return function()
    vim.env.FZF_DEFAULT_COMMAND =
        'fd --type file --hidden --follow --exclude .git'
    vim.g.fzf_action = {
        ['ctrl-s'] = 'split',
        ['ctrl-t'] = 'tab split',
        ['ctrl-v'] = 'vsplit'
    }
    vim.g.fzf_buffers_jump = 0
    vim.g.fzf_layout = {window = {width = 0.9, height = 0.9}}
    vim.g.fzf_preview_window = {'down:50%', 'ctrl-p'}

    vim.cmd([[
      nnoremap <Leader>+ :Rg<Space>
      nnoremap <Leader>/ :Rg<Space>
      nnoremap <Leader>? :Rg<Space>
      nnoremap <silent> <Backspace> :Buffers<CR>
      nnoremap <silent> <Leader>gL :Commits<CR>
      nnoremap <silent> <Leader>gg :GFiles?<CR>
      nnoremap <silent> <Leader>gl :BCommits<CR>
      nnoremap <silent> mm :Marks<CR>
      nnoremap <silent> ä :Files<CR>
      nnoremap <silent> å :BFiles<CR>
      nnoremap gR :Rg <c-r><c-w>
    ]])
end
