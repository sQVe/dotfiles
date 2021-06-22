--  ╻  ╻┏┓╻╺┳╸┏━╸┏━┓┏━┓
--  ┃  ┃┃┗┫ ┃ ┣╸ ┣┳┛┗━┓
--  ┗━╸╹╹ ╹ ╹ ┗━╸╹┗╸┗━┛
return {
    eslint = {
        formatCommand = "eslint_d --stdin --fix-to-stdout --stdin-filename ${INPUT}",
        formatStdin = true,
        lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
        lintFormats = {"%f(%l,%c): %tarning %m", "%f(%l,%c): %rror %m"},
        lintIgnoreExitCode = true,
        lintStdin = true
    },
    shellcheck = {
        lintCommand = "shellcheck -f gcc -x",
        lintFormats = {
            "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m",
            "%f:%l:%c: %tote: %m"
        }
    }
}
