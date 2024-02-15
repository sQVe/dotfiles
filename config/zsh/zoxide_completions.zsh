function __zoxide_z_complete() {
  # Show completions only if the cursor is at the end of the line ('words').
  # 'CURRENT' is the cursor's position in the 'words' array.
  [[ "${#words[@]}" -eq "${CURRENT}" ]] || return 0

  # Call '_cd' for two-word input to mimic `cd` completion.
  if [[ "${#words[@]}" -eq 2 ]]; then
    _cd
  # Ensures an empty last word and '__zoxide_z_prefix' not in the penultimate word hinting 'z' command usage.
  elif [[ "${words[-1]}" == '' ]] && [[ "${words[-2]}" != "${__zoxide_z_prefix}"?* ]]; then
    \builtin local result
    # Use '\command' to avoid alias or function conflict with 'zoxide'.
    # '--exclude' omits the current directory from results.
    if result="$(\command zoxide query --exclude "$(__zoxide_pwd)" --interactive -- ${words[2,-1]})"; then
      result="${__zoxide_z_prefix}${result}"
      compadd -Q "${(q-)result}"
    fi
    # Emit ANSI 'Device Status Report' control sequence.
    \builtin printf '\e[5n'
  fi
  return 0
}

# Bind '\e[0n' to 'reset-prompt', redrawing the prompt and running pre-redraw hooks.
\builtin bindkey '\e[0n' 'reset-prompt'
# Use compdef to associate '__zoxide_z' with its completion function.
[[ "${+functions[compdef]}" -ne 0 ]] && \compdef __zoxide_z_complete __zoxide_z
