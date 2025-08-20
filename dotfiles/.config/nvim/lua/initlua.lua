local path = require('plenary.path')

-- Cache to store previously found roots
local root_cache = {}

local function get_root(root_files)
  local bufnr = vim.api.nvim_get_current_buf()

  -- Return cached result if available
  if root_cache[bufnr] then
    return root_cache[bufnr]
  end

  local buf_name = vim.api.nvim_buf_get_name(0)
  if buf_name == '' then
    buf_name = vim.fn.getcwd() .. "/fake-file"
  end

  -- Traverse up the directory tree
  for dir in vim.fs.parents(buf_name) do
    for _, root_file in ipairs(root_files) do
      local check_path = path:new(dir) / root_file
      if check_path:exists() then
        root_cache[bufnr] = dir
        return dir
      end
    end
  end

  -- Cache nil result too
  root_cache[bufnr] = nil
  return nil
end


local function clear_cache(args)
  root_cache[args.buf] = nil
end

-- Clear cache when needed
vim.api.nvim_create_autocmd("BufDelete", {
  callback = clear_cache,
})

local function set_root(root_files)
  local root_dir = get_root(root_files)

  if root_dir then
    vim.api.nvim_set_current_dir(root_dir)
  end
end

-- Use only BufEnter for better performance
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local root_files = {
      ".git",
      "Makefile",
      "Cargo.toml",
      "package.json",
      "pyproject.toml",
      "setup.py",
      "requirements.txt",
    }
    set_root(root_files)
  end,
})

-- claude code
vim.api.nvim_create_user_command(
  "CustomClaudeCode",
  function(opts)
    local root_files = {".git", "Makefile"}
    local buf = vim.api.nvim_get_current_buf()

    -- Disable BufEnter autocmd temporarily
    local group = vim.api.nvim_create_augroup("custom_claude_code", { clear = true })
    vim.api.nvim_create_autocmd("BufEnter", {
      group = group,
      callback = function()
        return true  -- Block other BufEnter handlers
      end,
      once = true,
    })

    -- Clear root cache for current buffer
    clear_cache({ buf = buf })

    -- Force set_root with priority
    local root_dir = get_root(root_files)
    if root_dir then
      vim.api.nvim_set_current_dir(root_dir)
    end

    -- Launch Claude Code
    require("claudecode.terminal").simple_toggle({}, opts.args)
  end,
  {
    nargs = "*",
    desc = "Toggle Claude Code terminal from project root."
  }
)
