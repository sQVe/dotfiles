# CLAUDE.md

<critical_rules>
When reporting to me, be concise; sacrifice grammar for brevity.
Minimum viable change. Solve only what's asked.
Edit existing files. New files only when necessary.
Delete comments. Keep only those explaining why. Rewrite unclear code instead of commenting it.
When the request is ambiguous, list assumptions before acting.
Research before "I don't know" — WebSearch, WebFetch, Context7.
</critical_rules>

<principles>
Boring code wins. Clever code is bad code.
Build only what's needed now.
One function, one job. Split anything that does two.
One logical change per commit.
Descriptive names.
Negative space: carve valid behavior by rejecting invalid states. Fail loudly at the violation, not downstream.

```
// Good: getUserById, errorMessage, isAuthenticated
// Bad:  getUsr, errMsg, isAuth, btn, cb
```

</principles>

<writing>
Concise. Active voice. No fluff.
Use the `elements-of-style:writing-clearly-and-concisely` skill for prose.
</writing>
