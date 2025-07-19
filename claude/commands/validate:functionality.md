# Validate functionality and accessibility compliance

<instructions>
  <context>
    Verify functionality and accessibility for $ARGUMENTS through user workflow testing to ensure features work correctly and are accessible.
  </context>

  <requirements>
    - Functional development environment with running application
    - Clear specification of features or workflows to validate
    - Access to test data and realistic usage scenarios
    - Understanding of expected user experience and accessibility
    - Access to accessibility testing tools
  </requirements>

  <execution>
    1. **Quick analysis: Validation scope and testing approach**
       - Analyze $ARGUMENTS functionality scope and identify comprehensive testing strategy
       - Plan testing areas: user workflows, accessibility compliance, edge cases, error scenarios
       - Determine optimal testing sequence for thorough validation

    2. **Plan testing scope**
       - Identify primary user workflows for the specified functionality
       - Plan test scenarios covering normal usage and accessibility

    3. **Execute workflow and accessibility testing**
       - Test modified features through normal user workflows
       - Verify core functionality works as expected
       - Test accessibility compliance (WCAG 2.1 AA guidelines)
       - Validate ARIA labels, semantic HTML, and landmarks
       - Test keyboard navigation, focus management, and screen reader compatibility
       - Check color contrast ratios and visual accessibility
       - Validate responsive design across devices
       - Test user interface changes and behavior
       - Validate data persistence and state management

    4. **Edge cases and error scenarios**
       - Test boundary conditions and edge cases
       - Verify error handling and graceful failure scenarios
       - Test invalid input handling and validation messages
       - Validate assistive technology compatibility
       - Test mobile accessibility and touch interactions
       - Check content readability and cognitive accessibility
       - Confirm system stability under unusual conditions
  </execution>

  <validation>
    - [ ] Testing plan created for specified scope
    - [ ] Primary user workflows tested and functioning
    - [ ] Core functionality verified through realistic scenarios
    - [ ] WCAG 2.1 AA accessibility compliance validated
    - [ ] ARIA labels, semantic HTML, and landmarks verified
    - [ ] Keyboard navigation and screen reader compatibility tested
    - [ ] Color contrast and visual accessibility checked
    - [ ] Responsive design tested across device sizes
    - [ ] User interface changes behave as expected
    - [ ] Data persistence and state management validated
    - [ ] Edge cases and boundary conditions tested
    - [ ] Error handling scenarios verified
    - [ ] Assistive technology compatibility confirmed
    - [ ] Mobile accessibility and touch interactions validated
    - [ ] System stability confirmed under unusual conditions
  </validation>

  <workflow>
    **Part of validation workflow:**
    1. `/validate:code` - Automated linting, formatting, type checking
    2. `/validate:tests` - Test execution and coverage analysis
    3. `/validate:functionality` - Manual workflow and accessibility testing (current)
    4. `/validate:style` - Manual guideline compliance check
    5. `/finalize:commit` - Create clean commits after validation

    **Prerequisites:** Feature implementation complete, development environment running
    **Next steps:** Address any UX or accessibility issues, proceed to commit
    **Complements:** `/validate:security` and `/validate:performance` for comprehensive validation
  </workflow>

  <examples>
    ```bash
    # Test user authentication functionality and accessibility
    /validate:functionality "user authentication"

    # Process: test login/logout → password reset → session management → accessibility validation
    # Result: Comprehensive validation of authentication UX and accessibility compliance
    ```

    ```bash
    # Test specific feature workflows with accessibility
    /validate:functionality "checkout and payment flow"

    # Process: cart management → checkout → payment → confirmation → accessibility testing
    # Result: End-to-end validation of payment functionality and accessibility
    ```

    ```bash
    # Test form accessibility comprehensively
    /validate:functionality "registration form accessibility"

    # Process: form workflows → WCAG compliance → keyboard navigation → screen reader → mobile accessibility
    # Result: Comprehensive accessibility validation with WCAG 2.1 AA compliance testing
    ```

    ```bash
    # Test all modified features with accessibility
    /validate:functionality "all modified features"

    # Process: identify changed functionality → test each workflow → validate accessibility
    # Result: Complete validation of all recent feature changes including accessibility
    ```

    ```bash
    # Example validation results with accessibility
    # ✅ Login flow: Works correctly with proper error handling and accessibility
    # ✅ Password reset: Email sent, reset link functional, keyboard accessible
    # ✅ WCAG compliance: All interactive elements meet AA standards
    # ✅ Screen reader: All content properly announced and navigable
    # ⚠️  Session timeout: No clear user notification (affects accessibility)
    # ⚠️  Color contrast: Submit button fails WCAG AA standards (4.8:1 vs required 4.5:1)
    # ❌ Mobile accessibility: Button not responsive on small screens, touch targets too small
    ```

  </examples>
</instructions>
