local function get_root(root_files)
  local buf_name = vim.api.nvim_buf_get_name(0)
  if buf_name == '' then
    buf_name = vim.fn.getcwd() .. "/fake-file"
  end
  for dir in vim.fs.parents(buf_name) do
    for _, root_file in ipairs(root_files) do
      local to_check = dir .. "/" .. root_file
      if string.sub(dir, -1) == "/" then
        to_check = dir .. root_file
      end
      if vim.fn.empty(vim.fn.glob(to_check)) == 0 then
        return dir
      end
    end
  end
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

local function set_root()
  local root_dir = get_root(root_files)

  if root_dir then
    vim.api.nvim_set_current_dir(root_dir)
  end
end

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  callback = function() set_root() end,
})
