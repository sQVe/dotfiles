# Classifier models

In codemode scripts, use TypeSafe's direct Jev model for `models.classify()`:
`models.getModelOfType("classifier", "typesafe", "jev-latest")`. Fall back to
`openrouter/~typesafe/jev-latest` only when the direct call returns `stopReason: "error"`.
