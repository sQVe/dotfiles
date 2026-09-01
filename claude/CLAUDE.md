# CLAUDE.md

<critical_rules>
When reporting to me, be brief: short plain sentences, fewest words that stay readable. Cut content, not grammar; no fragments, arrow chains, or semicolon runs.
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
Descriptive names; no abbreviations, even idiomatic ones (getUserById not getUsr; no btn, cb, errMsg).
Negative space: carve valid behavior by rejecting invalid states. Fail loudly at the violation, not downstream.
</principles>
