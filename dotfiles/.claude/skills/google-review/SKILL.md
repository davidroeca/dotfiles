---
name: google-review
description: Review code following Google's engineering practices. Use when reviewing pull requests, evaluating code quality, or when asked to review changes using Google's standards.
disable-model-invocation: false
allowed-tools: Read, Grep, Glob, Bash(git *), AskUserQuestion
argument-hint: [branch or files]
---

# Google Code Review Skill

Conduct thorough first-pass code reviews following Google's engineering practices and principles. This review produces a complete written assessment; any follow-up discussion happens separately.

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

## Context Detection & Setup

Before starting, determine what to review and gather context.

### Step 0: Detect Review Context

- If available, and working for the given repo, use the gh cli to pull in relevant review context
- Otherwise:
  - Determine default branch (main, master, something else?)

### Step 1: Determine What to Review & Gather Context

```bash
# First check high-level diff counts
git diff <default_branch>...HEAD --stat

# If counts are small do a full 
git diff <default_branch>...HEAD

# Otherwise, batch the diffs to reduce context bloat
```

Also gather commit messages for context

```bash
git log $DEFAULT_BRANCH..HEAD --oneline
```

### Step 2: Review Scope Header

Begin the review output with a scope summary so the reader knows exactly what was reviewed:

```markdown
## Review Scope

- **Branch**: feature/new-feature (8 commits ahead of main)
- **Files changed**: 5 files, +200/-50 lines
- **Reviewing**: branch changes against main
```

Include a note about any missing context (e.g., "No commit messages describe intent, reviewing code directly").

## Review Process (Three-Step Approach)

### Step 1: Broad Assessment

First, evaluate whether this change should happen at all:

- Read commit messages to understand the stated goal
- Check if the change makes sense for the codebase
- Run/reference `git diff --stat` to understand the scope
- **If fundamental issues exist, note them prominently** - they take priority over details

If the change shouldn't happen or needs major redesign, say so clearly and why. Still complete the review of what exists.

### Step 2: Examine Core Components

Focus on the most significant files first:

- Identify files with the largest logical changes (not just line count)
- Review tests FIRST to understand intended behavior
- Check the main implementation files
- Look for design issues or architectural concerns

### Step 3: Systematic Review

Review all remaining files thoroughly:

- Go file by file in logical order
- Use the detailed checklist (see [checklist.md](./checklist.md))
- Document findings with specific file:line references
- Distinguish blocking issues from suggestions

## What to Look For

Review every change against these categories (see [checklist.md](./checklist.md) for details):

### 1. Design

- Do the interactions make sense?
- Does this belong in the codebase or in a library?
- Does it integrate well with the rest of the system?
- Is now the right time for this change?

### 2. Functionality

- Does the code do what the developer intended?
- Will it work well for users?
- Check edge cases, error handling, concurrency
- For UI changes: actually think through the user experience

### 3. Complexity

- Can other developers understand this code quickly?
- Is each piece doing too much?
- Watch for over-engineering and "future-proofing"
- If readers can't understand it quickly, it's too complex

### 4. Tests

- Are there appropriate tests (unit, integration, e2e)?
- Will tests actually catch bugs?
- Do tests cover edge cases?
- Are test implementations themselves clear?

### 5. Naming

- Are names descriptive and clear?
- Do they follow project conventions?
- Are they neither too short nor too verbose?

### 6. Comments

- Do comments explain WHY, not WHAT?
- Are complex algorithms explained?
- Are there any TODOs that should be addressed now?

### 7. Style & Consistency

- Does code follow the style guide?
- Is it consistent with surrounding code?
- Use "Nit:" prefix for non-blocking style suggestions

### 8. Documentation

- Are user-facing changes documented?
- Are READMEs updated if needed?
- Is API documentation current?

### 9. Security & Performance

- Are there security vulnerabilities?
- Are there obvious performance issues?
- Is user input properly validated?

## Clarification Interview (Before Writing)

After completing the analysis but before writing the file, identify findings where the correct suggestion depends on intent or context you cannot determine from the code alone. For each such finding, use `AskUserQuestion` to ask one focused question at a time and wait for the answer before proceeding to the next.

Ask when:
- Two equally valid approaches exist and the choice depends on project conventions or future plans
- A naming change has multiple reasonable options
- The right fix depends on whether a behavior is intentional

Do not ask when:
- The fix is unambiguous (e.g., a null check is clearly missing)
- It's a nit — note both options in the suggestion block instead
- The code is clearly wrong in only one way

Use each answer to write a concrete suggestion before moving to the next question. Do not write the file until all clarifications are complete.

## Output Format

Write the review to a new file named `review_{context}.md` in the current directory, where `{context}` is derived from the branch name (e.g., `feature/add-auth` -> `review_add-auth.md`) or, for uncommitted/file reviews, a short descriptor of what's being reviewed (e.g., `review_auth-login.md`). Never overwrite an existing file; append a numeric suffix (`_2`, `_3`) if needed.

Every finding — in any section — must use this exact format inline, no exceptions:

````markdown
**[Severity]** `path/to/file.ts:42`

Problem: [1-2 sentence explanation of problem]

```language
// the problematic lines exactly as they appear in the file
```

```language
// concrete suggested replacement; omit this block only if no specific fix is possible
```

[1-2 sentence explanation of what the fix improves OR 1-2 sentence explanation of high-level fix if no fix provided]
````

Structure the file as:

````markdown
## Review Scope

[branch, commits ahead, files changed; note any missing context]

## Summary

[2-3 sentences: what the change does, overall assessment]

## Blocking Issues

[Each finding in the format above. Omit section if none.]

## Design Feedback

[Each finding in the format above. Omit section if none.]

## Code Quality

[Each finding in the format above, grouped by file.]

## Suggestions

[Each finding in the format above, prefixed "Nit:".]

## Positives

[Specific callouts with file:line refs where relevant.]
````

In the review document:
- Avoid multiline paragraphs and list items.
- Use only typable characters on a qwerty keyboard.
- Speak in plain language, and avoid unnecessary jargon.


### Categorizing Findings

- **Blocking**: Correctness bugs, security vulnerabilities, design flaws, critical test gaps
- **Should Fix**: Poor naming, missing error handling, notable complexity, style violations
- **Nit**: Personal preferences, minor style, equally valid alternatives

When in doubt: will this matter in 6 months? If yes, blocking or should-fix. If no, nit or skip.

### Progressive Code Health

Code health improves through small steps, not rewrites.

- Each change should leave code healthier than it found it
- Accept "80% of ideal but better than current code"
- Flag "this makes the codebase worse" (blocking)
- Note "lateral — neither better nor worse" (nit at most)

### The "Clean Up Later" Problem

- Flag cleanup items clearly as should-fix; deferred cleanup is usually forgotten
- Categorize functional-but-messy code accurately: don't inflate or minimize severity
- Document the issue clearly; whether to insist on immediate cleanup is for the reviewer to decide

## Review Principles

- **Code health first**: maintain and gradually improve quality
- **Be specific**: "too complex" -> "this 80-line function does 4 things"
- **Be constructive**: "won't work" -> "fails when X=null; consider a null check"
- **Explain why**: include reasoning for non-obvious feedback
- **Acknowledge good work**: call out clever solutions
- **Objective over subjective**: code health, not personal preferences
- **Proportional depth**: match thoroughness to risk and change size

## Adaptation to Available Context

Match review depth to what's available:

- **Branch changes**: review vs. default branch; infer intent from commit messages; use file:line refs
- **Uncommitted changes only**: note missing commit context; focus on the diff
- **Specific files (no diff)**: note missing change context; focus on quality, patterns, security; can't assess goal achievement
- **Inline snippet**: note missing codebase context; general quality and security; can't assess integration

## Command Usage Examples

```bash
# Review current branch changes
/google-review

# Review a specific branch
/google-review feature/auth-system

# Review specific files
/google-review src/auth/login.ts src/auth/session.ts
```

## Remember

- Not every issue is blocking
- Improve code health incrementally
- Strict on design, flexible on style
- First pass only: flag everything worth noting; follow-up is separate
