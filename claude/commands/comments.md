# Comments Command

Systematically analyze and validate all comments in code against project guidelines.

## Usage

```
/comments <code-target>
```

## Instructions

You are helping validate comment quality and adherence to project guidelines.

1. **Read CLAUDE.md**
   - Load and review the global CLAUDE.md comment guidelines as your primary framework
   - Check for any project-specific CLAUDE.md that might override or extend the global guidelines

2. **Systematic comment discovery**
   - Use grep to find all comment patterns in the code target:
     - Single-line comments: `//`, `#`, `--`, `;`
     - Multi-line comments: `/* */`, `<!-- -->`, `""" """`, `''' '''`
     - Documentation comments: `/** */`, `///`, `#####`
   - Create a comprehensive list with file paths and line numbers for each comment found

3. **Strategic comment analysis**
   - Use ultrathink analysis to identify comments that add genuine value vs those that create noise
   - Focus on improving code maintainability through purposeful commenting practices

4. **Individual comment evaluation**
   - For each comment discovered, evaluate against these criteria:
     - **Value assessment**: Does it explain "why" (reasoning/business logic) rather than "what" (code mechanics)?
     - **Redundancy check**: Is the comment stating something already obvious from the code?
     - **Formatting validation**: Does it end with proper punctuation (., ?, or !)?
     - **Relevance verification**: Is the comment still accurate and up-to-date?

5. **Comment categorization**
   - **GOOD**: Comments that add genuine value
     - Business logic explanations
     - Complex algorithm reasoning
     - Non-obvious decisions or workarounds
     - Performance implications
     - Assumptions or constraints
   - **REDUNDANT**: Comments that should be removed
     - Function name repetition
     - Obvious operations description
     - Variable explanations for self-descriptive names
     - Setter/getter descriptions
     - Basic loop descriptions
   - **NEEDS_IMPROVEMENT**: Comments with potential value but poor execution
     - Missing punctuation
     - Explains "what" instead of "why"
     - Out-of-date information
     - Unclear or ambiguous phrasing

6. **Generate detailed report**
   - **Summary statistics**: Total comments found, breakdown by category
   - **File-by-file analysis**: Organize findings by source file
   - **Specific locations**: Provide exact file paths and line numbers
   - **Remediation guidance**: For each issue, suggest specific actions:
     - GOOD: "Keep as-is, adds value"
     - REDUNDANT: "Remove - code is self-explanatory"
     - NEEDS_IMPROVEMENT: "Rewrite to explain reasoning: [specific suggestion]"
   - **Priority ranking**: Focus on high-impact improvements first

## Examples

```bash
# Validate comments in specific directory
/comments src/components/

# Validate comments in all changed files
/comments changes

# Validate comments in specific file
/comments Button.tsx

# Validate comments in entire project
/comments .
```

## Sample Evaluation Process

For each comment found:

1. **Context**: What code does this comment relate to?
2. **Purpose**: What is the comment trying to communicate?
3. **Value**: Does it help a developer understand something non-obvious?
4. **Quality**: Is it well-written and properly formatted?
5. **Action**: Keep, remove, or improve with specific recommendation
