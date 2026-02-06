# CLAUDE.md

<critical_rules>
Minimum viable change. Solve only what's asked.
Edit existing files. New files only when necessary.
Delete comments. Keep only those explaining why. Rewrite unclear code instead of commenting it.
Research before "I don't know" — WebSearch, WebFetch, Context7.

Before responding, silently verify compliance with these rules.
</critical_rules>

<principles>
Boring code wins. Clever code is bad code.
Build only what's needed now.
One function, one job. Split anything that does two.
One logical change per commit.
Descriptive names.

```
// Good: getUserById, errorMessage, isAuthenticated
// Bad:  getUsr, errMsg, isAuth, btn, cb
```

</principles>

<typescript>
Infer types. Omit return types when inferable (Math.*, literals, simple expressions).
Use `??` for defaults, `||` only for intentional falsy checks.
Use `if (value != null)` for null checks.
Use `null` over `undefined` for intentional absence.
Use `unknown` instead of `any`.
Use arrow functions. Use `function` for generators and overloads.
Use braces for all control flow statements.
Use explicit checks instead of `!` assertions.
</typescript>

<writing>
Concise. Active voice. No fluff.
Use APA sentence case for titles and headings.
Use the `elements-of-style:writing-clearly-and-concisely` skill for prose.
</writing>
