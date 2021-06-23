--  ┏━╸┏━┓┏━┓┏┳┓┏━┓╺┳╸╺┳╸┏━╸┏━┓┏━┓
--  ┣╸ ┃ ┃┣┳┛┃┃┃┣━┫ ┃  ┃ ┣╸ ┣┳┛┗━┓
--  ╹  ┗━┛╹┗╸╹ ╹╹ ╹ ╹  ╹ ┗━╸╹┗╸┗━┛
return {
    gofmt = {formatCommand = "gofmt", formatStdin = true},
    luaformat = {formatCommand = "lua-format -i", formatStdin = true},
    prettier = {
        formatCommand = "node /home/sqve/code/prettier_d_slim/lib/bin/prettier_d_slim.js --stdin --stdin-filepath ${INPUT}",
        formatStdin = true
    },
    shfmt = {formatCommand = 'shfmt -i 2 -bn -ci -sr', formatStdin = true}
}
