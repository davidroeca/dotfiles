local Path = require("plenary.path")
local M = {}

-- Key: Absolute directory path | Value: { global = path, local_pkg = path }
local dir_cache = {}

-- Your specific monorepo/workspace patterns
local LOCAL_PATTERNS = {
  ".git",
  "Makefile",
  "Cargo.toml",
  "package.json",
  "pyproject.toml",
  "setup.py",
  "requirements.txt",
}

local function find_root(start_dir, patterns, find_highest)
  local found = nil
  local homedir = vim.uv.os_homedir()

  -- Check the starting directory first, then walk up
  local dirs_to_check = { start_dir }
  for _, parent in ipairs(start_dir:parents()) do
    table.insert(dirs_to_check, parent)
  end

  for _, dir in ipairs(dirs_to_check) do
    local dir_str = tostring(dir)
    -- Stop at home to prevent accidental OS-wide scans
    if dir_str == homedir then
      break
    end

    for _, pattern in ipairs(patterns) do
      local test_path = Path:new(dir_str, pattern)
      if test_path:exists() then
        if not find_highest then
          return dir_str
        end
        found = dir_str
        break
      end
    end
  end
  return found
end

function M.get_roots(force)
  local buf_path = vim.api.nvim_buf_get_name(0)
  local start_dir

  if buf_path == "" or buf_path == nil then
    -- No buffer open, use current working directory
    start_dir = Path:new(vim.fn.getcwd())
  else
    -- Buffer open, use its parent directory
    start_dir = Path:new(buf_path):parent()
  end

  local cache_key = tostring(start_dir)

  -- Return cached version if it exists and we aren't forcing a refresh
  if not force and dir_cache[cache_key] then
    return dir_cache[cache_key]
  end

  local roots = {
    global = find_root(start_dir, { ".git" }, true),
    local_pkg = find_root(start_dir, LOCAL_PATTERNS, false)
  }

  dir_cache[cache_key] = roots
  return roots
end

function M.cd_global(force)
  local roots = M.get_roots(force)
  if roots.global then
    vim.api.nvim_set_current_dir(roots.global)
    vim.notify("🌍 Global Root: " .. roots.global)
  else
    vim.notify("❌ No .git found.")
  end
end

function M.cd_local(force)
  local roots = M.get_roots(force)
  if roots.local_pkg then
    vim.api.nvim_set_current_dir(roots.local_pkg)
    vim.notify("📦 Local Workspace: " .. roots.local_pkg)
  else
    vim.notify("❌ No local root patterns found.")
  end
end

return M
