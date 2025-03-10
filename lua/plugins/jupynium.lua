return {
  {
    "kiyoon/jupynium.nvim",
    build = "pip3 install --user .",
    config = function()
      require("jupynium").setup({
        python_host = vim.g.python3_host_prog or "python3",
        default_notebook_URL = "localhost:8888/nbclassic",
        jupyter_command = "jupyter",
        firefox_profiles_ini_path = "~/.mozilla/firefox/profiles.ini",
        firefox_profile_name = "default",
      })
    end,
  },
}
