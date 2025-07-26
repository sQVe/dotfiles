# Docs Review Command

Perform comprehensive documentation review analyzing quality, clarity, technical accuracy, and improvement opportunities.

## Usage

```
/docs-review <documentation-target>
```

## Instructions

You are helping conduct a thorough documentation review.

1. **Read CLAUDE.md**
   - Load and review the global CLAUDE.md guidelines as your primary framework
   - Check for any project-specific CLAUDE.md that might override or extend the global guidelines

2. **Strategic documentation analysis**
   - Use ultrathink analysis to evaluate user journey and information architecture, guiding all subsequent steps
   - Identify documentation gaps that block user success or create confusion
   - Prioritize fixes by user impact: onboarding blockers, missing prerequisites, outdated examples

3. **Analyze the provided documentation**
   - Identify type (API docs, tutorials, guides, README) and target audience
   - Determine scope, affected sections, and potential impact

4. **Review content quality and structure**
   - **Clarity**: Flag unclear explanations and confusing language
   - **Organization**: Check logical flow and heading hierarchy
   - **Completeness**: Ensure purpose, prerequisites, and outcomes are covered
   - **User experience**: Identify gaps in user journey

5. **Review technical accuracy and accessibility**
   - **Technical correctness**: Verify code examples and API references
   - **Link validity**: Check external links are active and relevant
   - **Accessibility**: Verify descriptive links, alt text, semantic structure
   - **Version accuracy**: Validate version numbers and compatibility

6. **Review style and formatting**
   - **Writing style**: Check voice, tone, and terminology consistency
   - **Formatting**: Verify headings, lists, code blocks, and emphasis
   - **Grammar**: Identify errors, typos, and awkward phrasing
   - **Title consistency**: Prefer sentence case headings; flag inconsistencies within the document
   - **Standards**: Ensure adherence to style guides and conventions

7. **Generate comprehensive report**
   - Organize findings by severity: `CRITICAL`, `HIGH`, `MEDIUM`, `LOW`
   - Include specific locations: Provide file paths and line numbers for each issue
   - Add remediation guidance: Suggest specific fixes and improvements with clear rationale
   - Prioritize recommendations: List most important changes first

## Examples

```bash
# Review all modified documentation
/docs-review "changes"

# Review specific documentation file
/docs-review "README.md"

# Review specific documentation section
/docs-review "API documentation"
```
