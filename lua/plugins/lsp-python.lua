-- ~/.config/nvim/lua/plugins/python-jupyter.lua
return {
  -- Configure LSP for Python and Jupyter notebooks
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Ensure options are initialized
      opts.servers = opts.servers or {}

      -- Configure Pyright for Jupyter notebook support
      opts.servers.pyright = vim.tbl_deep_extend("force", opts.servers.pyright or {}, {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              diagnosticMode = "workspace",
              inlayHints = {
                variableTypes = true,
                functionReturnTypes = true,
              },
              -- Include .ipynb in analysis
              extraFileExtensions = { "ipynb" },
            },
          },
        },
        filetypes = { "python", "ipynb" },
      })

      return opts
    end,
  },

  -- Make sure file detection works for Jupyter notebooks
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      opts.filetype_extend = opts.filetype_extend or {}
      opts.filetype_extend.python = opts.filetype_extend.python or {}

      -- Add .ipynb files to be recognized as python
      if not vim.tbl_contains(opts.filetype_extend.python, "ipynb") then
        table.insert(opts.filetype_extend.python, "ipynb")
      end

      return opts
    end,
  },

  -- Ensure Pyright is installed via Mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      if not vim.tbl_contains(opts.ensure_installed, "pyright") then
        table.insert(opts.ensure_installed, "pyright")
      end

      return opts
    end,
  },

  -- Add proper treesitter support
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      if not vim.tbl_contains(opts.ensure_installed, "python") then
        table.insert(opts.ensure_installed, "python")
      end

      return opts
    end,
  },
}
