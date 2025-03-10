-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
local last_theme = nil

local function sync_theme()
  -- get dekstop color-scheme
  local function log_debug(msg)
    vim.notify("Theme Debug: " .. msg, vim.log.levels.INFO)
  end

  local handle = io.popen("gsettings get org.gnome.desktop.interface color-scheme")
  if not handle then
    log_debug("Failed to run gsettings command")
    return
  end

  local result = handle:read("*a")
  handle:close()

  --Clean up the result
  result = result:gsub("^%s*'?", ""):gsub("'?%s*$", "")

  -- parse the result
  if result ~= last_theme then
    log_debug("Theme changed from " .. tostring(last_theme) .. " to " .. result)
    last_theme = result
    local is_dark = result == "prefer-dark"

    -- set the appropriate theme
    if is_dark then
      vim.schedule(function()
        vim.o.background = "dark"
        vim.cmd("colorscheme tokyonight")
      end)
    else
      vim.schedule(function()
        vim.o.background = "light"
        vim.cmd("colorscheme catppuccin")
      end)
    end
  end
end

-- create autocommand group for theme sync
local theme_group = vim.api.nvim_create_augroup("ThemeSync", { clear = true })

-- check theme on startup
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  group = theme_group,
  callback = sync_theme,
})

-- set up timer to check theme periodically
local timer = vim.uv.new_timer()
if timer then
  timer:start(
    200,
    100,
    vim.schedule_wrap(function()
      sync_theme()
    end)
  )
end
