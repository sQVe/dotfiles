---
globs:
  - '**/*.sh'
---

Double-quote all variable expansions with braces: `"${var}"`, not `"$var"`.
Lowercase `readonly` for script constants; UPPERCASE only for exported env vars.
Use `#!/usr/bin/env bash` shebang.
Use `set -euo pipefail` strict mode.
Verify with shellcheck (`-s bash`, not POSIX).
Declare function variables with `local`.
Use `[[ ]]` for tests, never `[ ]`.
Send error messages to stderr (`>&2`).
Use `command -v` to check tool availability.
