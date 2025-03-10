return {
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
    keys = {
      {
        "<leader>cn",
        function()
          return ":IncRename " .. vim.fn.expand("<cword")
        end,
        expr = true,
        desc = "IncRename",
      },
    },
  },
}
