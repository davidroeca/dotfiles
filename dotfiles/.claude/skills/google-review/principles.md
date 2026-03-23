# Code Review Principles

Core principles for producing effective, balanced code review feedback.

**Based on**: [Google's Engineering Practices - Handling Pushback](https://google.github.io/eng-practices/review/reviewer/pushback.html)

These principles have been adapted for first-pass written reviews where follow-up discussion happens separately.

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

Code health improves through many small steps, not giant rewrites.

### The Philosophy

- **Perfect is the enemy of good**: Code doesn't need to be perfect
- **Better than before**: Each change should leave code healthier than it found it
- **Small, consistent improvements**: Tiny quality gains compound over time
- **Don't let quality slide**: Maintain the bar that's been set

### In Practice

- **Accept**: "This is 80% of ideal but better than current code"
- **Flag**: "This makes the codebase worse" (blocking)
- **Note**: "This is lateral - neither better nor worse" (nit at most)

## The "Clean Up Later" Problem

When code contains something that should be cleaned up:

- **Flag it clearly** in the review as a should-fix item
- Note that cleanup deferred usually means cleanup forgotten
- If the code is functional but messy, categorize appropriately - don't inflate severity, but don't minimize it either

The review's job is to document the issue clearly. Whether to insist on immediate cleanup is a decision for whoever acts on the review.

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

- **Be specific**: "This function is too complex" -> "This 80-line function does 4 different things"
- **Be constructive**: "This won't work" -> "This fails when X=null. Consider adding a null check"
- **Acknowledge good work**: "Nice error handling here" or "Clever optimization"
- **Explain why**: Always include reasoning for non-obvious feedback
- **Focus on the code, not the author**: "This function could be simpler" not "You made this too complicated"

### Avoid

- Sarcasm or snark
- "Obviously..." or "Everyone knows..."
- "Just..." (minimizes difficulty)
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

When in doubt: **Will this matter in 6 months?** If yes, mark it as blocking or should-fix. If no, mark it as a nit or skip it entirely.
