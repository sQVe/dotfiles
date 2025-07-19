# Analyze project dependencies and dependency health

<instructions>
  <context>
    Analyze project dependencies, their health, security status, and impact on $ARGUMENTS to understand dependency landscape and identify potential issues.
  </context>

  <requirements>
    - Access to package files (package.json, requirements.txt, Cargo.toml, etc.)
    - Understanding of the specific dependencies or areas to analyze
    - Ability to check dependency versions and security advisories
  </requirements>

  <execution>
    1. **Dependency discovery and mapping**
       - Verify $ARGUMENTS is provided (dependency name/pattern or "all" for full analysis)
       - If no argument provided, show error: "Please specify dependencies to analyze (e.g., 'react ecosystem' or 'all')"
       - Locate and parse package files across the project
       - Map direct dependencies and their versions
       - Identify transitive dependencies and dependency trees
       - Document dependency sources and package managers used

    2. **Health and security analysis**
       - Check for outdated dependencies and available updates
       - Identify deprecated packages and maintenance status
       - Scan for known security vulnerabilities and advisories
       - Analyze dependency size and bundle impact
       - Review license compatibility and compliance issues

    3. **Dependency relationships and conflicts**
       - Examine version conflicts and peer dependency issues
       - Identify duplicate dependencies and potential optimizations
       - Analyze dependency update impact and breaking changes
       - Review dependency alternatives and replacement options
  </execution>

  <validation>
    - [ ] Package files located and parsed successfully
    - [ ] Direct and transitive dependencies mapped
    - [ ] Security vulnerabilities identified and documented
    - [ ] Outdated packages and update recommendations provided
    - [ ] Version conflicts and peer dependency issues analyzed
    - [ ] License compatibility and compliance reviewed
  </validation>

  <workflow>
    **Part of research workflow:**
    - `/research:dependencies` - Analyze dependency health and security (current)
    - `/security:scan` - Cross-validate dependency vulnerabilities
    - `/implement:optimization` - Address performance issues from dependencies

    **Prerequisites:** Project with package files (package.json, requirements.txt, etc.)
    **Next steps:** Address identified issues, update dependencies as needed
    **Best timing:** Regular dependency audits, before major releases
  </workflow>

  <examples>
    ```bash
    # Analyze all project dependencies
    /research:dependencies "all"

    # Process: parse package files → map dependencies → check security → analyze health
    # Result: Comprehensive dependency health report with update recommendations
    ```

    ```bash
    # Focus on specific ecosystem
    /research:dependencies "react ecosystem"

    # Process includes:
    # - Find React-related dependencies (react, react-dom, react-router, etc.)
    # - Check versions compatibility and peer dependencies
    # - Identify security issues in React ecosystem packages
    # - Suggest updates and migration paths for outdated React packages
    ```
  </examples>
</instructions>