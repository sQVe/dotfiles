# Review Docs Command

Validate documentation for grammar, style consistency, clarity, and adherence to best practices.

## Usage
```
/review-docs <documentation-target>
```

## Instructions
You are helping ensure documentation quality and consistency. Follow these steps:

1. **Review documentation against standards** including grammar, structure, and technical elements

2. **Validate compliance and quality** for clarity, consistency, and accessibility

3. **Provide actionable feedback** with specific corrections and improvement recommendations

## Guidelines

### **Style & Structure:**
- Consistent voice, tone, and terminology throughout
- Active voice preferred, hierarchical heading structure
- Table of contents for documents over 5 sections
- Overview explaining purpose, next steps at end

### **Technical Quality:**
- Code examples compile and execute correctly
- API references match current implementation
- External links active and relevant
- Installation instructions work end-to-end
- Version numbers and compatibility accurate

### **Accessibility:**
- Descriptive link text (avoid "click here")
- Alt text for images and screenshots
- Adequate color contrast and semantic HTML
- Keyboard navigation instructions for interactive elements

### **Completeness:**
- Purpose, prerequisites, expected outcomes
- Troubleshooting for common issues
- Examples for major concepts
- Glossary for technical terms

## Examples
```bash
# Validate specific documentation file
/review-docs README.md

# Validate all documentation changes
/review-docs changes

# Validate entire documentation set
/review-docs "all documentation"
```
