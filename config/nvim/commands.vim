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
command! CommitMsgPrev vsplit .git/PREV_COMMIT_EDITMSG


"  ┏━╸╻ ╻┏┓╻┏━╸╺┳╸╻┏━┓┏┓╻   ┏━╸┏━┓┏┳┓┏┳┓┏━┓┏┓╻╺┳┓┏━┓
"  ┣╸ ┃ ┃┃┗┫┃   ┃ ┃┃ ┃┃┗┫   ┃  ┃ ┃┃┃┃┃┃┃┣━┫┃┗┫ ┃┃┗━┓
"  ╹  ┗━┛╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹   ┗━╸┗━┛╹ ╹╹ ╹╹ ╹╹ ╹╺┻┛┗━┛

" Create and print Ascii Header.
command! -nargs=1 AsciiHeader call AsciiHeader(<q-args>)

" Use branch name as commit message.
command! -nargs=0 CommitMsgFromBranchName call CommitMsgFromBranchName()

" Search on DuckDuckGo.
command! -nargs=? Ddg call Ddg(<q-args>)

" Show documentation.
command! -nargs=0 ShowDocumentation call ShowDocumentation()

" Z lookup.
command! -nargs=1 Z call Z(<q-args>)
