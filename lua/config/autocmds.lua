-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
local last_theme = nil

local function get_gtk_theme()
  -- local handle = io.popen("gsettings get org.gnome.desktop.interface gtk-theme 2>/dev/null")
  local handle = io.popen("grep '^\\$GTK_THEME=' ~/.config/hypr/themes/wallbash.conf | cut -d= -f2 2>/dev/null")
  if not handle then
    return nil
  end
  local result = handle:read("*a")
  handle:close()
  return result:gsub("^%s*'?", ""):gsub("'?%s*$", ""):lower()
end

local function sync_theme()
  local gtk_theme = get_gtk_theme()
  if not gtk_theme or gtk_theme == last_theme then
    return
  end
  last_theme = gtk_theme

  if gtk_theme:find("oxo") then
    vim.schedule(function()
      vim.o.background = "dark"
      vim.cmd("colorscheme oxocarbon")
    end)
  elseif gtk_theme:find("vanta") then
    vim.schedule(function()
      vim.o.background = "dark"
      vim.cmd("colorscheme oxocarbon")
    end)
  elseif gtk_theme:find("tokyo") then
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

-- Autocommand group for theme sync
local theme_group = vim.api.nvim_create_augroup("ThemeSync", { clear = true })

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  group = theme_group,
  callback = sync_theme,
})

-- Filetype for .ipynb
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.ipynb",
  callback = function()
    vim.bo.filetype = "ipynb"
  end,
})

-- Poll every 1s (1000ms) — gsettings is cheap to call
local timer = vim.uv.new_timer()
if timer then
  timer:start(200, 1000, vim.schedule_wrap(sync_theme))
end
