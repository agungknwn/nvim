return {
  "nvim-flutter/flutter-tools.nvim",
  lazy = false, -- or true/false depending on when you want it loaded
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- optional but recommended for better UI
    -- "mfussenegger/nvim-dap",
  },
  config = function()
    require("flutter-tools").setup({
      -- put your custom config here (see below)
      ui = {
        border = "rounded",
        notification_style = "native", -- or "plugin"
      },
      decorations = {
        statusline = {
          app_version = true,
          device = true,
          project_config = false,
        },
      },
      debugger = {
        enabled = true, -- enable DAP integration
        exception_breakpoints = {}, -- e.g. { "all" } etc
        evaluate_to_string_in_debug_views = true,
      },
      flutter_path = "/usr/bin/flutter",
      flutter_lookup_cmd = nil,
      root_patterns = { ".git", "pubspec.yaml" },
      fvm = false,
      default_run_args = nil, -- e.g. { flutter = "--no-version-check" }
      widget_guides = {
        enabled = true,
      },
      closing_tags = {
        highlight = "ErrorMsg",
        prefix = ">",
        priority = 10,
        enabled = true,
      },
      dev_log = {
        enabled = true,
        filter = nil,
        notify_errors = false,
        open_cmd = "15split",
        focus_on_open = true,
      },
      dev_tools = {
        autostart = false,
        auto_open_browser = false,
      },
      outline = {
        open_cmd = "30vnew",
        auto_open = false,
      },
      lsp = {
        color = {
          enabled = false,
          background = false,
          background_color = nil,
          foreground = false,
          virtual_text = true,
          virtual_text_str = "■",
        },
        on_attach = function(client, bufnr)
          -- You can put your custom on_attach logic here
          -- e.g. keymaps for hover, goto-definition, etc.
          local map = vim.keymap.set
          local opts = { buffer = bufnr, silent = true }
          map("n", "gd", vim.lsp.buf.definition, opts)
          map("n", "K", vim.lsp.buf.hover, opts)
          map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          -- Flutter-specific mappings
          map("n", "<leader>FR", ":FlutterRun<CR>", opts)
          map("n", "<leader>Fq", ":FlutterQuit<CR>", opts)
          map("n", "<leader>Frl", ":FlutterReload<CR>", opts)
          map("n", "<leader>Frs", ":FlutterRestart<CR>", opts)
          map("n", "<leader>Fo", ":FlutterOutlineToggle<CR>", opts)
          map("n", "<leader>FD", ":FlutterDevices<CR>", opts)
          map("n", "<leader>Fe", ":FlutterEmulators<CR>", opts)
          map("n", "<leader>Fdt", ":FlutterDevTools<CR>", opts)
          map("n", "<leader>Fl", ":FlutterLogToggle<CR>", opts)
          map("n", "<leader>Fc", ":FlutterLogClear<CR>", opts)

          -- 🆕 Waydroid keymaps
          -- 🧱 Hyprland: Dynamic Waydroid resize
          -- Variables to remember last width/height
          local waydroid_width = 400
          local waydroid_height = 800

          -- Set width interactively
          map("n", "<leader>Fwrw", function()
            vim.ui.input({ prompt = "Enter Waydroid width (px): ", default = tostring(waydroid_width) }, function(input)
              if input then
                waydroid_width = tonumber(input) or waydroid_width
                vim.notify("Waydroid width set to " .. waydroid_width .. "px", vim.log.levels.INFO)
              end
            end)
          end, opts)

          -- Set height interactively
          map("n", "<leader>Fwrh", function()
            vim.ui.input(
              { prompt = "Enter Waydroid height (px): ", default = tostring(waydroid_height) },
              function(input)
                if input then
                  waydroid_height = tonumber(input) or waydroid_height
                  vim.notify("Waydroid height set to " .. waydroid_height .. "px", vim.log.levels.INFO)
                end
              end
            )
          end, opts)

          -- Resize using current width/height
          map("n", "<leader>FwR", function()
            vim.fn.jobstart({
              "hyprctl",
              "dispatch",
              "resizewindowpixel",
              "exact",
              tostring(waydroid_width),
              tostring(waydroid_height),
              "--",
              "class:^(Waydroid)$",
            }, { detach = true })

            vim.notify("Resized Waydroid to " .. waydroid_width .. "x" .. waydroid_height, vim.log.levels.INFO)
          end, opts)
          map("n", "<leader>Fws", function()
            vim.fn.jobstart({ "waydroid", "show-full-ui" }, { detach = true })
            vim.notify("Waydroid launched (full UI)", vim.log.levels.INFO)
          end, opts)

          map("n", "<leader>Fwq", function()
            vim.fn.jobstart({ "waydroid", "session", "stop" }, { detach = true })
            vim.notify("Waydroid stopped", vim.log.levels.WARN)
          end, opts)
        end,
        capabilities = nil, -- you can pass your `capabilities` from nvim-cmp, etc.
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          analysisExcludedFolders = { "/path/to/flutter/sdk/packages" },
          renameFilesWithClasses = "prompt",
          enableSnippets = true,
          updateImportsOnRename = true,
        },
      },
    })
  end,
}
