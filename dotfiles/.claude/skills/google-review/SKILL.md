---
name: google-review
description: Review code following Google's engineering practices. Use when reviewing pull requests, evaluating code quality, or when asked to review changes using Google's standards.
disable-model-invocation: false
allowed-tools: Read, Grep, Glob, Bash(git *)
argument-hint: [branch or files]
---

# Google Code Review Skill

Conduct thorough first-pass code reviews following Google's engineering practices and principles. This review produces a complete written assessment; any follow-up discussion happens separately.

## Attribution

This skill is based on **Google's Engineering Practices Documentation**:

- [How to do a code review](https://google.github.io/eng-practices/review/reviewer/)
- [Navigating a CL](https://google.github.io/eng-practices/review/reviewer/navigate.html)
- [What to look for in a code review](https://google.github.io/eng-practices/review/reviewer/looking-for.html)

These principles have been adapted for use with Claude Code and expanded with additional context-handling capabilities.

## Context Detection & Setup

**CRITICAL**: Before starting the review, determine what you're reviewing and gather necessary context.

### Step 0: Detect Review Context

Run these checks in parallel to understand the environment:

```bash
# Check if we're in a git repo
git rev-parse --git-dir 2>/dev/null && echo "Git repo: yes" || echo "Git repo: no"

# Check current branch
git branch --show-current 2>/dev/null

# Check for uncommitted changes
git status --short

# Check for a default branch
git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@'
```

### Step 1: Determine What to Review

Based on the invocation and context, identify what needs review:

#### Scenario A: Branch Name Provided (`$ARGUMENTS` contains a branch name)

```bash
# Check changes on the specified branch vs default branch
DEFAULT_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
DEFAULT_BRANCH=${DEFAULT_BRANCH:-main}

git diff $DEFAULT_BRANCH...$ARGUMENTS --stat
```

#### Scenario B: No Arguments, In a Git Repo

Infer what to review:

```bash
# Check for changes against the default branch
DEFAULT_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
DEFAULT_BRANCH=${DEFAULT_BRANCH:-main}

git diff $DEFAULT_BRANCH...HEAD --stat
```

**Decision logic**:

1. If there are commits ahead of the default branch -> Review branch changes
2. If on the default branch with uncommitted changes -> Review uncommitted changes only
3. If on the default branch with no changes -> State that there is nothing to review and stop

#### Scenario C: File Paths Provided

If `$ARGUMENTS` contains file paths, review those specific files.

#### Scenario D: Not in a Git Repo or No Changes

If there is no git context and no code was provided inline, state that there is nothing to review and stop.

### Step 2: Gather Context

Once you know what to review, gather the necessary information:

#### For Branch Reviews:

```bash
DEFAULT_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
DEFAULT_BRANCH=${DEFAULT_BRANCH:-main}

# Changes since branching
git diff $DEFAULT_BRANCH...HEAD --stat

# Full diff
git diff $DEFAULT_BRANCH...HEAD

# Commit messages for context
git log $DEFAULT_BRANCH..HEAD --oneline
```

#### For Uncommitted Changes:

```bash
# Staged and unstaged changes
git diff HEAD --stat
git diff HEAD
```

#### For File-Specific Reviews:

```bash
# If files are specified, check for changes
git diff $FILE_PATH

# Or read the current file state
# Use Read tool for specific files
```

### Step 3: Review Scope Header

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
- Run `git diff --stat` to understand the scope
- **If fundamental issues exist, note them prominently** - they take priority over details

**Decision point**: If the change shouldn't happen or needs major redesign, state this clearly in the review and explain why. Still complete the review of what exists.

### Step 2: Examine Core Components

Focus on the most significant files first:

- Identify files with the largest logical changes (not just line count)
- Review tests FIRST to understand intended behavior
- Check the main implementation files
- Look for design issues or architectural concerns

### Step 3: Systematic Review

Review all remaining files thoroughly:

- Go file by file in logical order
- Use the detailed checklist (see [checklist.md](checklist.md))
- Document findings with specific file:line references
- Distinguish blocking issues from suggestions

## What to Look For

Review every change against these categories (see [checklist.md](checklist.md) for details):

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
- **"Can't be understood quickly by code readers" = too complex**

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

## Output Format

Structure your review as:

```markdown
## Review Scope

[What was reviewed, branch info, files changed]

## Summary

[2-3 sentence overview: what changes, overall assessment]

## Blocking Issues

[Issues that MUST be fixed before merge - empty if none]

## Design Feedback

[Architectural or design concerns - empty if none]

## Code Quality

[Specific improvements organized by file]

## Suggestions (Non-blocking)

[Nice-to-have improvements, marked with "Nit:"]

## Positives

[What was done well - be specific]
```

### Categorizing Findings

Use these categories consistently:

- **Blocking**: Correctness bugs, security vulnerabilities, design flaws that will cause future problems, critical test gaps
- **Should Fix**: Poor naming that obscures intent, missing error handling, notable complexity, style violations against codebase standards
- **Nit**: Personal preferences, minor style points, alternative approaches that are equally valid

When in doubt: **Will this matter in 6 months?** If yes, mark it blocking or should-fix. If no, mark it as a nit or skip it.

## Review Principles

Follow these principles when writing findings (see [principles.md](principles.md)):

- **Focus on code health**: The goal is to maintain and gradually improve codebase quality
- **Be specific**: "This function is too complex" -> "This 80-line function does 4 different things"
- **Be constructive**: "This won't work" -> "This fails when X=null. Consider adding a null check"
- **Explain why**: Always include reasoning for non-obvious feedback
- **Acknowledge good work**: Call out clever solutions or improvements
- **Objective over subjective**: Focus on code health, not personal preferences
- **Proportional depth**: Match review thoroughness to the risk and size of the change

## Adaptation to Available Context

Your review depth should match available context:

### Branch Changes Available

- Review code changes vs. default branch
- Infer intent from commit messages
- Full file:line references

### Uncommitted Changes Only

- Review staged/unstaged changes
- Note: "Reviewing uncommitted changes without commit context"
- Focus on the diff itself

### Specific Files (No Diff)

- Review current code state
- Note: "Reviewing current file state without change context"
- Focus on code quality, patterns, security
- Cannot assess if change achieves intended goal

### Code Snippets (Inline)

- Review provided code in isolation
- Note: "Reviewing provided snippet without codebase context"
- General code quality and security feedback
- Cannot assess integration or completeness

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

- Every line matters, but not every issue is blocking
- The goal is to improve code health incrementally
- Be strict on design, flexible on style
- This is a first pass - flag everything worth noting, follow-up happens separately
