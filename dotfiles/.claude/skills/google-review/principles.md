# Code Review Principles

Core principles for effective, balanced reviews. Based on [Google's Engineering Practices - Handling Pushback](https://google.github.io/eng-practices/review/reviewer/pushback.html), adapted for first-pass written reviews.

## The Goal of Code Review

**Primary Goal**: Maintain and gradually improve code health

**Secondary Goals**:

- Ensure code is maintainable by others
- Catch bugs and design issues early
- Maintain consistency across the codebase

**NOT the Goal**:

- Making code perfect
- Enforcing personal preferences
- Blocking progress on minor issues

## Categorizing Findings

### Blocking Issues (Must Fix)

These should be clearly marked and must be resolved before merge:

1. **Correctness**: Code doesn't work or will break in production
2. **Security**: Vulnerabilities or data exposure
3. **Design flaws**: Will make future changes significantly harder
4. **Test gaps**: Critical paths untested
5. **Severe complexity**: Code is unmaintainable

### Should Fix (Important but Not Blocking)

These improve code health and should be addressed, but are negotiable:

1. **Naming**: Poor names that obscure intent
2. **Style violations**: Inconsistent with codebase standards
3. **Missing comments**: Complex logic unexplained
4. **Performance**: Notable efficiency issues
5. **Error handling**: Missing or inadequate

### Nit (Suggestions Only)

These are optional improvements - use the "Nit:" prefix:

1. **Personal preferences**: Your way isn't objectively better
2. **Minor style points**: Automated tools could fix these
3. **Alternate approaches**: Multiple valid solutions exist
4. **Future improvements**: Could be separate follow-up work

## Progressive Code Health

Code health improves through small steps, not rewrites.

- Each change should leave code healthier than it found it
- Accept "80% of ideal but better than current code"
- Flag "this makes the codebase worse" (blocking)
- Note "lateral — neither better nor worse" (nit at most)

## The "Clean Up Later" Problem

- Flag cleanup items clearly as should-fix; deferred cleanup is usually forgotten
- Categorize functional-but-messy code accurately: don't inflate or minimize severity
- Document the issue clearly; whether to insist on immediate cleanup is for the reviewer to decide

## Writing Effective Feedback

### Good Review Comment Structure

```markdown
**[Category]**: [Specific issue]

Current code: `[code snippet]`
Problem: [Why this is an issue]
Suggestion: [How to fix it]
Reason: [Why the fix is better]
```

Example:

```markdown
**Complexity**: This nested loop is hard to follow

Current code: `for (x in items) { for (y in x.children) { ... } }`
Problem: 3 levels of nesting make logic unclear
Suggestion: Extract inner loop to `processChildren(x)`
Reason: Easier to test and understand in isolation
```

### Tone Guidelines

- **Specific**: "too complex" -> "this 80-line function does 4 things"
- **Constructive**: "won't work" -> "fails when X=null; consider a null check"
- **Acknowledge good work**: "nice error handling" or "clever optimization"
- **Explain why**: include reasoning for non-obvious feedback
- **Code, not author**: "this function could be simpler" not "you made this too complicated"

### Avoid

- Sarcasm, "Obviously...", "Everyone knows...", "Just..."
- Demands without explanation
- Nitpicking without the "Nit:" prefix

## Quick Decision Tree

```
Is this issue...

  Breaks functionality/security? -> BLOCKING, must fix
  Creates future problems?       -> SHOULD FIX, explain impact
  Could be better?               -> NIT, use "Nit:" prefix
  Different but equally valid?   -> Skip or brief nit at most
```

When in doubt: will this matter in 6 months? If yes, blocking or should-fix. If no, nit or skip.
