--  ┏━╸┏━┓┏━┓┏┳┓┏━┓╺┳╸╺┳╸┏━╸┏━┓┏━┓
--  ┣╸ ┃ ┃┣┳┛┃┃┃┣━┫ ┃  ┃ ┣╸ ┣┳┛┗━┓
--  ╹  ┗━┛╹┗╸╹ ╹╹ ╹ ╹  ╹ ┗━╸╹┗╸┗━┛
return {
    gofmt = {formatCommand = "gofmt", formatStdin = true},
    luaformat = {formatCommand = "lua-format -i", formatStdin = true},
    prettier = {
        formatCommand = "prettier_d_slim --stdin --stdin-filepath ${INPUT}",
        formatStdin = true
    },
    shfmt = {formatCommand = 'shfmt -i 2 -bn -ci -sr', formatStdin = true}
}
