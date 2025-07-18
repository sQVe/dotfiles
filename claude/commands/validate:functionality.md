# Validate user experience and accessibility compliance manually

<instructions>
  <context>
    Manually verify functionality for $ARGUMENTS through user workflow testing to ensure features work correctly in real-world scenarios.
  </context>

  <requirements>
    - Functional development environment with running application
    - Clear specification of features or workflows to validate
    - Access to test data and realistic usage scenarios
    - Understanding of expected user experience and edge cases
  </requirements>

  <execution>
    1. **Validate scope and plan testing**
       - Verify $ARGUMENTS is provided (specific features/workflows to test required)
       - If no scope provided, show error: "Please specify what to validate (e.g., 'user authentication', 'payment flow', 'all modified features')"
       - Identify primary user workflows for the specified functionality
       - Plan test scenarios covering normal usage patterns

    2. **Execute user workflow and accessibility testing**
       - Test modified features through normal user workflows and interactions
       - Verify core functionality works as expected in realistic scenarios
       - Test accessibility compliance (ARIA labels, keyboard navigation, screen reader support)
       - Validate responsive design across devices and screen sizes
       - Test user interface changes and ensure proper behavior
       - Validate data persistence and state management across sessions

    3. **Edge case and error scenario validation**
       - Test boundary conditions and edge cases for specified functionality
       - Verify error handling and graceful failure scenarios
       - Test invalid input handling and validation messages
       - Confirm system remains stable under unusual conditions
  </execution>

  <validation>
    - [ ] Scope argument provided and testing plan created
    - [ ] Primary user workflows tested and functioning correctly
    - [ ] Core functionality verified through realistic usage scenarios
    - [ ] Accessibility compliance validated (ARIA, keyboard navigation, screen reader)
    - [ ] Responsive design tested across multiple device sizes
    - [ ] User interface changes behave as expected
    - [ ] Data persistence and state management validated
    - [ ] Edge cases and boundary conditions tested
    - [ ] Error handling scenarios verified
    - [ ] System stability confirmed under unusual conditions
  </validation>

  <examples>
    ```bash
    # Test user authentication functionality
    /validate:functionality "user authentication"

    # Process: test login/logout → password reset → session management
    # Result: Comprehensive validation of authentication user experience
    ```

    ```bash
    # Test specific feature workflows
    /validate:functionality "checkout and payment flow"

    # Process: cart management → checkout → payment → confirmation
    # Result: End-to-end validation of payment functionality
    ```

    ```bash
    # Test all modified features
    /validate:functionality "all modified features"

    # Process: identify changed functionality → test each workflow
    # Result: Complete validation of all recent feature changes
    ```

    ```bash
    # Test accessibility and user experience
    /validate:functionality "form submission and accessibility"

    # Process: test form workflows → keyboard navigation → screen reader → responsive design
    # Result: Comprehensive accessibility and UX validation
    ```

    ```bash
    # Example validation results
    # ✅ Login flow: Works correctly with proper error handling
    # ✅ Password reset: Email sent, reset link functional
    # ✅ Keyboard navigation: All interactive elements accessible via Tab
    # ⚠️  Session timeout: No clear user notification
    # ⚠️  Color contrast: Submit button fails WCAG AA standards
    # ❌ Mobile login: Button not responsive on small screens
    ```
  </examples>
</instructions>