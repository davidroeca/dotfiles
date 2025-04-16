require("paq")({
  "https://github.com/tpope/vim-scriptease.git", -- color scheme debugging
  "https://github.com/itchyny/lightline.vim.git", -- Airline/Powerline replacement
  "https://github.com/pangloss/vim-javascript.git", -- JS/JSX support
  "https://github.com/peitalin/vim-jsx-typescript.git", -- TSX support
  "https://github.com/neoclide/jsonc.vim.git",
  "https://github.com/autowitch/hive.vim.git",
  "https://github.com/scrooloose/nerdcommenter.git", -- for quick commenting

  "https://github.com/ntpeters/vim-better-whitespace.git", -- Highlight trailing whitespace;

  "https://github.com/tpope/vim-ragtag.git", -- html tag management
  "https://github.com/jparise/vim-graphql.git", -- graphql highlights
  "https://github.com/airblade/vim-rooter.git", -- roots directory at git repo
  "https://github.com/scrooloose/nerdtree.git", -- file browsing
  "https://github.com/ctrlpvim/ctrlp.vim.git", -- fuzzy file search (like find)
  "https://github.com/wincent/ferret.git", -- find/replace
   -- REPLs
  "https://github.com/pappasam/nvim-repl.git",
  -- For writing
  "https://github.com/junegunn/goyo.vim.git",
  "https://github.com/junegunn/limelight.vim.git",
  -- For autocompletion
  {
    "https://github.com/neoclide/coc.nvim.git",
    build = "npm ci",
  },
  "https://github.com/pappasam/vim-filetype-formatter.git", -- running code formatters
  "https://github.com/tyru/open-browser.vim.git",
  -- Syntax highlight support, as well as text objects, etc.
  "https://github.com/nvim-treesitter/nvim-treesitter.git",
  "https://github.com/nvim-treesitter/playground.git",
  "https://github.com/pappasam/papercolor-theme-slim", -- color scheme
})

vim.lsp.enable("basedpyright")
vim.lsp.enable("bashls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("svelte")
vim.lsp.enable("terraformls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("vimls")
vim.lsp.enable("yamlls")

vim.lsp.config("*", {
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = false, -- https://github.com/neovim/neovim/issues/23291
      },
    },
  },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          "vim",
          "require",
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

vim.lsp.config("yamlls", {
  filetypes = { "yaml" },
  settings = {
    yaml = {
      schemas = {
        kubernetes = "/kubernetes/**",
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/refs/heads/main/schema/compose-spec.json"] = "/*docker-compose.yml",
        ["https://raw.githubusercontent.com/threadheap/serverless-ide-vscode/master/packages/serverless-framework-schema/schema.json"] = "/*serverless.yml",
        ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/3.0.3/schemas/v3.0/schema.json"] = {
          "/*open-api*.yml",
          "/*open-api*.yaml",
        },
      },
      customTags = {
        "!ENV scalar",
        "!ENV sequence",
        "!relative scalar",
        "tag:yaml.org,2002:python/name:material.extensions.emoji.to_svg",
        "tag:yaml.org,2002:python/name:material.extensions.emoji.twemoji",
        "tag:yaml.org,2002:python/name:pymdownx.superfences.fence_code_format",
      },
    },
  },
})

vim.diagnostic.config({
  jump = {
    float = true,
  },
})

require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
    disable = function(lang, bufnr)
      if lang == "javascript"
        or lang == "javascriptreact"
        or lang == "typescript"
        or lang == "typescriptreact"
        or lang == "svelte"
      then
        return vim.api.nvim_buf_line_count(bufnr) > 10000
      end
      return vim.api.nvim_buf_line_count(bufnr) > 50000
    end,
  },
  indent = {
    enable = true,
    disable = function(lang, bufnr)
      return vim.api.nvim_buf_line_count(bufnr) > 10000
    end,
  },
  ensure_installed = "all",
})

vim.treesitter.language.register("terraform", "terraform-vars")
vim.treesitter.language.register("bash", "zsh")
vim.treesitter.language.register("bash", "shell")
