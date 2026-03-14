-- In ~/.config/nvim/lua/config/conform.lua or in your lazy config
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      json = { "prettier" },
      jsp = { "prettier" },
      sql = { "pg_format_system" }, -- USE SYSTEM formatter
      dart = { "dart_format" },
    },

    -- Define custom formatter pointing to system pg_format
    formatters = {
      pg_format_system = {
        command = "pg_format", -- this uses /usr/bin/pg_format
        args = { "-" }, -- read from stdin
        stdin = true,
      },
    },

    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
