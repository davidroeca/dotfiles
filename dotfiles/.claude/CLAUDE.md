# TypeScript/JavaScript preferences

- Use 2 spaces for indentation
- Prefer ES Modules (import) syntax over CommonJS (require) syntax. If it's known that certain configuration files need `require`, then those exceptions are allowed.
- Try to run `biome format --write` on generated code if biome is available, otherwise fall back to `prettier` (first `npx prettier`, then global).
- Prefer TypeScript/TSX over JavaScript/JSX whenever possible
- When using TypeScript, avoid `any` if at all possible; use `unknown` instead if needed
- TypeScript generics are encouraged if they help avoid repetition
- Prefer functional programming over classes, unless explicit instance state management is required.

# Python preferences

- Use 4 spaces for indentation
- Use type hints for all generated code
- Prefer Python 3.11+ features and type hints. Avoid Any type whenever possible.
- Aim for line length of 80
- Include a docstring
- If the project includes a ruff configuration, try ruff autoformatting generated python code
- Prefer functional programming over classes, unless explicit instance state management is required
- If there is no `pyproject.toml`, check for a `.venv` or a `venv` to activate prior to running commands
- If the project has `pyproject.toml`, check the contents to understand the package management and command runner tool.
- If `poetry` is used, make sure to prefix comands with `poetry run`. Otherwise, assume `uv` is the default tool, and prefix commands with `uv run`.

# Writing preferences

- Use American English spelling and dialect (e.g. "color" not "colour", "analyze" not "analyse")
- Do not use em dashes in prose. This includes both the Unicode em dash character and the double-hyphen (--) convention. Use a comma, colon, semicolon, or period to restructure the sentence instead.

# Browser Automation Preferences

- Always use Firefox browser for Playwright automation
- Default to Firefox when taking screenshots or testing
- Use Firefox developer tools integration when available
