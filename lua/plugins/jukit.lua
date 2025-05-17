return {
  -- {
  --   "GCBallesteros/jupytext.nvim",
  --   lazy = false,
  --   config = function()
  --     require("jupytext").setup({
  --       style = "hydrogen",
  --       output_extension = "auto",
  --       force_ft = nil,
  --     })
  --   end,
  -- },
  {
    "luk400/vim-jukit",
    lazy = false,
    config = function()
      vim.g.jukit_terminal = "kitty"
      vim.g.jukit_output_new_os_window = 1
      vim.g.jukit_inline_plotting = 1
      vim.g.jukit_notebook_viewer = "code"

      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.cmd("highlight jukit_cellmarker_colors guifg=#1d615a guibg=#1d615a ctermbg=22 ctermfg=22")
        end,
      })
    end,
  },
}
