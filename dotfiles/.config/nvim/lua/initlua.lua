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

  local file_path = path:new(buf_name)

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

local root_files = {
  ".git",
  "Makefile",
  "Cargo.toml",
  "package.json",
  "pyproject.toml",
  "setup.py",
  "requirements.txt",
}

-- Clear cache when needed
vim.api.nvim_create_autocmd("BufDelete", {
  callback = function(args)
    root_cache[args.buf] = nil
  end,
})

local function set_root()
  local root_dir = get_root(root_files)

  if root_dir then
    vim.api.nvim_set_current_dir(root_dir)
  end
end

-- Use only BufEnter for better performance
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function() set_root() end,
})
