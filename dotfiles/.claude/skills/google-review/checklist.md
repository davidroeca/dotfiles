# Code Review Detailed Checklist

Use this checklist during the systematic review step. Not every item applies to every change.

**Based on**: [Google's Engineering Practices - What to Look For](https://google.github.io/eng-practices/review/reviewer/looking-for.html)

Categories and criteria have been expanded with specific checkboxes and detailed guidance.

## Design

### Integration

- [ ] Does this change integrate cleanly with existing systems?
- [ ] Are dependencies reasonable and well-justified?
- [ ] Would this be better as a separate library or service?
- [ ] Does it follow existing architectural patterns?

### Timing & Scope

- [ ] Is this the right time for this change?
- [ ] Is the scope appropriate, or should it be split?
- [ ] Are there prerequisites that should land first?

### Abstractions

- [ ] Are abstractions at the right level?
- [ ] Is the interface design clean and intuitive?
- [ ] Does it avoid leaking implementation details?

## Functionality

### Core Behavior

- [ ] Does the code do what the PR description says?
- [ ] Does it solve the stated problem?
- [ ] Will it work correctly for all users?

### Edge Cases

- [ ] What happens with empty/null/zero inputs?
- [ ] What happens at scale (large data, many users)?
- [ ] How does it handle errors and failures?
- [ ] What about concurrent access or race conditions?

### User Experience

- [ ] For UI: Is the interaction intuitive?
- [ ] Are error messages helpful?
- [ ] Is performance acceptable for users?

## Complexity

### Code Clarity

- [ ] Can you understand what the code does in under 30 seconds?
- [ ] Are functions/methods doing one thing?
- [ ] Is the control flow straightforward?
- [ ] Are there deeply nested structures that could be flattened?

### Over-engineering Watch

- [ ] Is there code for speculative future features?
- [ ] Are abstractions justified by actual usage?
- [ ] Is configuration complexity warranted?
- [ ] Could this be simpler and still work?

### Signal: "I need to read this 3 times to understand it"

If you have this feeling, the code is too complex. Request simplification.

## Tests

### Coverage

- [ ] Are there tests for the new functionality?
- [ ] Are tests at the right level (unit vs integration vs e2e)?
- [ ] Do tests cover edge cases?
- [ ] Are error paths tested?

### Quality

- [ ] Will tests actually catch bugs if code breaks?
- [ ] Are tests readable and maintainable?
- [ ] Do tests avoid unnecessary complexity?
- [ ] Are test names descriptive?

### What's NOT Required

- [ ] Don't require tests for trivial changes
- [ ] Don't require 100% coverage if 80% is sufficient
- [ ] Don't require testing framework changes

## Naming

### Variables & Functions

- [ ] Are names descriptive enough?
- [ ] Do names match their purpose?
- [ ] Are boolean names clearly true/false (is*, has*, should\*)?
- [ ] Are names too abbreviated or too verbose?

### Consistency

- [ ] Do names follow project conventions?
- [ ] Are similar things named similarly?
- [ ] Are different things named differently?

## Comments

### Good Comments (encourage these)

- [ ] WHY decisions were made
- [ ] Non-obvious algorithm explanations
- [ ] Warnings about gotchas or subtle behavior
- [ ] Links to tickets, RFCs, or external docs
- [ ] Legal/licensing information

### Bad Comments (request removal)

- [ ] WHAT the code does (code should be self-explanatory)
- [ ] Outdated information contradicting code
- [ ] Commented-out code (use version control)
- [ ] Obvious statements

### TODOs

- [ ] Should TODOs be fixed now or later?
- [ ] Do TODOs have ticket numbers or owners?
- [ ] Are there too many TODOs (tech debt piling up)?

## Style & Consistency

### Formatting

- [ ] Does code match the style guide?
- [ ] Is formatting consistent with surrounding code?
- [ ] Are line lengths reasonable?
- [ ] Is indentation correct?

### Patterns

- [ ] Does code follow established patterns in the codebase?
- [ ] Are idioms used correctly?
- [ ] Is error handling consistent with the project?

### Nitpicks

- [ ] Mark style-only issues with "Nit:" prefix
- [ ] Don't block on personal preferences
- [ ] Reference style guide for objective issues

## Documentation

### User-Facing Docs

- [ ] Are public APIs documented?
- [ ] Is the README updated if behavior changes?
- [ ] Are migration guides provided for breaking changes?
- [ ] Are examples up to date?

### Developer Docs

- [ ] Are architecture decisions documented (ADRs)?
- [ ] Is complex logic explained in docs?
- [ ] Are setup instructions current?

### When to Skip

- [ ] Internal-only changes may not need user docs
- [ ] Obvious changes don't need extra documentation

## Security

### Input Validation

- [ ] Is user input validated and sanitized?
- [ ] Are SQL queries parameterized (no injection)?
- [ ] Is XSS prevented in web contexts?
- [ ] Are file paths validated (no traversal)?

### Authentication & Authorization

- [ ] Are authentication checks present?
- [ ] Are authorization checks at the right layer?
- [ ] Are permissions checked before sensitive operations?

### Data Protection

- [ ] Are secrets kept out of logs?
- [ ] Is sensitive data encrypted appropriately?
- [ ] Are passwords hashed (never stored plaintext)?

### Common Vulnerabilities

- [ ] No command injection vulnerabilities
- [ ] No insecure deserialization
- [ ] No hardcoded credentials
- [ ] No exposed debug endpoints in production

## Performance

### Obvious Issues

- [ ] No N+1 query patterns
- [ ] Are database indexes used appropriately?
- [ ] Are expensive operations cached when appropriate?
- [ ] Are large datasets paginated?

### Scalability

- [ ] Will this work with 10x the data?
- [ ] Are there memory leaks?
- [ ] Are resources (connections, files) properly cleaned up?

### When NOT to Optimize

- [ ] Don't prematurely optimize
- [ ] Don't micro-optimize unless profiling shows issues
- [ ] Clarity > minor performance gains

## Dependencies

### New Dependencies

- [ ] Is the dependency necessary?
- [ ] Is it well-maintained and secure?
- [ ] Does it have reasonable license terms?
- [ ] Could we use existing dependencies instead?

### Versions

- [ ] Are version constraints appropriate?
- [ ] Are security advisories checked?

## Error Handling

### Robustness

- [ ] Are errors caught and handled appropriately?
- [ ] Are error messages useful for debugging?
- [ ] Are errors logged with sufficient context?

### Fail-Safe Behavior

- [ ] What happens when external services fail?
- [ ] Are timeouts set appropriately?
- [ ] Is retry logic reasonable?

### What NOT to Do

- [ ] Don't catch errors silently
- [ ] Don't use errors for control flow
- [ ] Don't log sensitive data in errors

---

## Review Priority Guide

**Priority 1 (Must check)**: Design, Functionality, Security
**Priority 2 (Should check)**: Complexity, Tests, Error Handling
**Priority 3 (Can be quick)**: Style, Naming, Comments

Focus depth on higher-priority categories first. Lower-priority items can be covered more briefly for smaller changes.
