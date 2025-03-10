return {
  {
    "3rd/image.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
          require("nvim-treesitter.configs").setup({
            ensure_installed = { "markdown" },
            highlight = { enable = true },
          })
        end,
      },
    },
    opts = {
      backend = "kitty",
      processor = "magick_rock",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
        },
        neorg = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "norg" },
        },
        typst = {
          enabled = true,
          filetypes = { "typst" },
        },
      },
      max_width = 999,
      max_height = 999,
      max_width_window_percentage = math.huge,
      max_height_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      -- kitty_method = "normal",
    },
  },
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- this is an example, not a default. Please see the readme for more configuration options
      vim.g.molten_image_provider = "image.nvim"
      -- vim.g.molten_output_win_max_height = 20
      vim.g.molten_output_win_max_width = 250

      -- Add function to detect and run cells with # %% delimiter
      local function setup_magma_cell_detection()
        -- Function to find and evaluate code cells
        vim.api.nvim_create_user_command("MoltenEvaluateCell", function()
          local current_line = vim.api.nvim_win_get_cursor(0)[1]
          local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

          -- Find the start of the current cell
          local cell_start = current_line
          while cell_start > 1 and not lines[cell_start - 1]:match("^# %%") do
            cell_start = cell_start - 1
          end

          -- Find the end of the current cell (looking for next cell marker or EOF)
          local cell_end = current_line
          while cell_end < #lines do
            if cell_end + 1 <= #lines and lines[cell_end + 1]:match("^# %%") then
              break
            end
            cell_end = cell_end + 1
          end

          -- If we're on a cell marker line, start from the next line
          if lines[cell_start]:match("^# %%") then
            cell_start = cell_start + 1
          end

          -- Only evaluate if there's content
          if cell_start <= cell_end then
            -- Select the cell and evaluate it
            vim.api.nvim_win_set_cursor(0, { cell_start, 0 })
            vim.api.nvim_command("normal! V")
            vim.api.nvim_win_set_cursor(0, { cell_end, 0 })
          end
        end, {})

        -- Function to move to the next cell and evaluate it
        vim.api.nvim_create_user_command("MoltenEvaluateNextCell", function()
          local current_line = vim.api.nvim_win_get_cursor(0)[1]
          local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

          -- Find the start of the next cell
          local next_cell = current_line
          while next_cell < #lines do
            if lines[next_cell + 1]:match("^# %%") then
              break
            end
            next_cell = next_cell + 1
          end

          if next_cell < #lines then
            -- Move to the next cell and evaluate it
            vim.api.nvim_win_set_cursor(0, { next_cell + 1, 0 })
          end
        end, {})
      end

      -- Set up the cell detection when Magma is initialized
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "python", "julia", "r" },
        callback = function()
          setup_magma_cell_detection()
        end,
      })
    end,
  },
}
