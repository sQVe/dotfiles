--  ╻  ┏━╸┏┓╻┏━┓
--  ┃  ┣╸ ┃┗┫┗━┓
--  ┗━╸┗━╸╹ ╹┗━┛
return function()
    vim.cmd([[
        let g:lens#animate = 0
        let g:lens#height_resize_max = 30
        let g:lens#height_resize_min = 10
        let g:lens#width_resize_max = 100
        let g:lens#width_resize_min = 20
    ]])
end
