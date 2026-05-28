return {
  -- Wire sqlfluff as linter via nvim-lint (LazyVim includes this)
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        sql = { "sqlfluff" },
      },
    },
  },
}
