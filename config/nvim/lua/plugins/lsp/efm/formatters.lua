--  ┏━╸┏━┓┏━┓┏┳┓┏━┓╺┳╸╺┳╸┏━╸┏━┓┏━┓
--  ┣╸ ┃ ┃┣┳┛┃┃┃┣━┫ ┃  ┃ ┣╸ ┣┳┛┗━┓
--  ╹  ┗━┛╹┗╸╹ ╹╹ ╹ ╹  ╹ ┗━╸╹┗╸┗━┛
return {
    gofmt = {formatCommand = "gofmt", formatStdin = true},
    luaformat = {formatCommand = "lua-format -i", formatStdin = true},
    prettier = {
        formatCommand = 'prettierd "${INPUT}"',
        formatStdin = true,
        env = {"PRETTIERD_LOCAL_PRETTIER_ONLY=true"}
    },
    shfmt = {formatCommand = 'shfmt -i 2 -bn -ci -sr', formatStdin = true}
}
