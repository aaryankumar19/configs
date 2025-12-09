---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.recipes.disable-tabline" },
  {
    "tomiis4/BufferTabs.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional
    },
    lazy = false,
    config = function()
      local buffertabs = require "buffertabs"
      buffertabs.setup {
        -- your config here
      }

      -- Toggle BufferTabs with t
      vim.keymap.set("n", "t", function() buffertabs.toggle() end, { desc = "Toggle BufferTabs" })
    end,
  },
  {
    "sphamba/smear-cursor.nvim",
    opts = {},
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup {
        variant = "dark",
        transparent = true,
        colors = {
          -- make text lighter
          fg = "#eeeeee", -- very light gray
          dark = {
            fg = "#ffffff", -- pure white for dark variant
          },
        },
      }
      vim.cmd.colorscheme "cyberdream"
    end,
  },
}
