return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "default",
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide" },
      ["<CR>"] = { "accept", "fallback" },

      ["<Tab>"] = { "accept", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },

      ["<A-j>"] = { "select_next", "fallback" },
      ["<A-k>"] = { "select_prev", "fallback" },

      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },
  },
}
