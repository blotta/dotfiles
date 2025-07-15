local M = {}

-- Store the previous cwd
M.prev_cwd = nil

-- Function to toggle between config dir and previous cwd
function M.toggle_config_cwd()
  local cwd = vim.loop.cwd()
  local config_dir = vim.fn.stdpath("config")
  local nvimtree = require('nvim-tree.api')

  if cwd == config_dir then
    -- If currently in config, go back to previous
    if M.prev_cwd and #M.prev_cwd > 0 then
      vim.fn.chdir(M.prev_cwd)
	  nvimtree.tree.change_root(M.prev_cwd)
      vim.notify("cwd → " .. M.prev_cwd)
      M.prev_cwd = nil
    else
      vim.notify("No previous directory stored", vim.log.levels.WARN)
    end
  else
    -- Save current cwd and switch to config
    M.prev_cwd = cwd
    vim.fn.chdir(config_dir)
	  nvimtree.tree.change_root(config_dir)
    vim.notify("cwd → " .. config_dir)
  end
end

-- Keybinding: <leader>cd toggles
vim.keymap.set("n", "<leader>cf", M.toggle_config_cwd, {
  desc = "Toggle between current cwd and Neovim config dir",
})

