return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---type Flash.Config
    opts = {
      modes = {
        search = { enabled = false }
      }
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "<C-s>",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      -- {
      --   "R",
      --   mode = "o", -- operator pending mode (e.g., d.., y..)
      --   function()
      --     require("flash").remote()
      --   end,
      --   desc = "Remote Flash",
      -- },
      {
        "r",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Flash Treesitter Search",
      },
      -- {
      --   "<c-s>",
      --   mode = { "c" }, -- command mode (used when searching with "/")
      --   function()
      --     require("flash").toggle()
      --   end,
      --   desc = "Toggle Flash Search",
      -- },
    },
  },
}
