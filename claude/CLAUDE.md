# CLAUDE.md

<critical_rules>
Minimum viable change. Solve only what's asked.
Edit existing files. New files only when necessary.
Comments explain WHY. Unclear WHAT means rewrite the code. Remove redundant comments.
Research before "I don't know" — WebSearch, WebFetch, Context7.
Infer types. Annotate only when TypeScript gets it wrong.

Before responding, silently verify compliance with these rules.
</critical_rules>

<principles>
Boring code wins. Clever code is bad code.
Build only what's needed now.
One function, one job. Split anything that does two.
One logical change per commit.
</principles>

<typescript>
Use `??` for defaults, not `||`.
Use `if (value != null)` for null checks.
Use `null` over `undefined` for intentional absence.
Use `unknown` instead of `any`.
Use explicit checks instead of `!` assertions.
Use arrow functions. Use `function` for generators and overloads.
</typescript>

<writing>
Concise. Active voice. No fluff.
Use APA sentence case for titles and headings.
Use the `elements-of-style:writing-clearly-and-concisely` skill for prose.
</writing>
