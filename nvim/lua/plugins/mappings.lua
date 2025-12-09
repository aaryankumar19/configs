return {
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["vv"] = { "V", desc = "Select entire line" },
          ["<C-a>"] = { "ggVG", desc = "Select entire file" },

          -- Move line up or down
          ["<A-j>"] = { ":m .+1<CR>==", desc = "Move line down" },
          ["<A-k>"] = { ":m .-2<CR>==", desc = "Move line up" },

          -- Disabled
          ["<leader>h"] = false,
        },
      },
    },
  },
}
