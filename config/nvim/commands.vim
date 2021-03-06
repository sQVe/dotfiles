"  ┏┓ ┏━┓┏━┓┏━╸   ┏━╸┏━┓┏┳┓┏┳┓┏━┓┏┓╻╺┳┓┏━┓
"  ┣┻┓┣━┫┗━┓┣╸    ┃  ┃ ┃┃┃┃┃┃┃┣━┫┃┗┫ ┃┃┗━┓
"  ┗━┛╹ ╹┗━┛┗━╸   ┗━╸┗━┛╹ ╹╹ ╹╹ ╹╹ ╹╺┻┛┗━┛

" Clear marks.
command! ClearMarks :delm! | delm A-Z0-9 | wshada!

" Clear registers.
command! ClearRegisters for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

" Delete all open buffers.
command! Bda bufdo bd

" Delete all buffers but the open one.
command! Bdo %bd|e#|bd#

" Show full path to open buffer.
command! Bpwd echo expand('%:p')

" Set pwd to path of open buffer.
command! Cdb cd %:p:h

" Copy.
command! Copy norm ggyG

" Term.
command! Term !term
command! BTerm !term '%:p'

" Write, close and quit typos.
command! W write
command! Q quit
command! Wq wq
command! WQ wq
command! Qa qa
command! QA qa
command! Wa wa
command! WA wa
command! Wbc Wbc

" Open prev git commit message.
command! PrevCommitMsg vsplit .git/PREV_COMMIT_EDITMSG


"  ┏━╸╻ ╻┏┓╻┏━╸╺┳╸╻┏━┓┏┓╻   ┏━╸┏━┓┏┳┓┏┳┓┏━┓┏┓╻╺┳┓┏━┓
"  ┣╸ ┃ ┃┃┗┫┃   ┃ ┃┃ ┃┃┗┫   ┃  ┃ ┃┃┃┃┃┃┃┣━┫┃┗┫ ┃┃┗━┓
"  ╹  ┗━┛╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹   ┗━╸┗━┛╹ ╹╹ ╹╹ ╹╹ ╹╺┻┛┗━┛

" Create and print Ascii Header.
command! -nargs=1 AsciiHeader call PrintAsciiHeader(<q-args>)

" Format buffer.
command! -nargs=0 Format call Format()

" Search on DuckDuckGo.
command! -nargs=? Ddg call Search('duckduckgo', <q-args>)

" Search on DevDocs.
command! -nargs=? DevDocs call Search('devdocs', <q-args>)

" Show documentation.
command! -nargs=0 ShowDocumentation call ShowDocumentation()

" Toggle concealing.
command! -nargs=0 ToggleConceal call ToggleConceal()

" Toggle relative numbering.
command! -nargs=0 ToggleRelativeNumber call ToggleRelativeNumber()

" Toggle spell checking.
command! -nargs=0 ToggleSpellCheck call ToggleSpellCheck()

" Z lookup.
command! -nargs=1 Z call Z(<q-args>)


"  ┏━┓╻  ╻ ╻┏━╸╻┏┓╻   ┏━╸┏━┓┏┳┓┏┳┓┏━┓┏┓╻╺┳┓┏━┓
"  ┣━┛┃  ┃ ┃┃╺┓┃┃┗┫   ┃  ┃ ┃┃┃┃┃┃┃┣━┫┃┗┫ ┃┃┗━┓
"  ╹  ┗━╸┗━┛┗━┛╹╹ ╹   ┗━╸┗━┛╹ ╹╹ ╹╹ ╹╹ ╹╺┻┛┗━┛

" FZF.
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
command! -bang BFiles
  \ call fzf#vim#files(expand('%:p:h'), fzf#vim#with_preview('right:50%', '?'), <bang>0)
command! -bang -nargs=* Rg
  \ call fzf#vim#rg(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)

" Coc command helpers.
command! GChunkInfo CocCommand git.chunkInfo
command! GChunkStage CocCommand git.chunkStage
command! GChunkUndo CocCommand git.chunkUndo
command! GCopyUrl CocCommand git.copyUrl
command! YankList CocList -A --normal yank

" Update plugins and coc extensions.
command! Update CocUpdateSync | PlugUpdate | TSUpdate
