-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- vim.opt.clipboard = ""
-- vim.opt.mouse = ""

vim.schedule(function()
  vim.opt.clipboard:append("unnamedplus")

  local function paste()
    return {
      vim.fn.split(vim.fn.getreg(""), "\n"),
      vim.fn.getregtype(""),
    }
  end

  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      -- WezTerm does not allow to read clipboard via OSC 52
      -- ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      -- ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
      ["+"] = paste,
      ["*"] = paste,
    },
  }
end)
