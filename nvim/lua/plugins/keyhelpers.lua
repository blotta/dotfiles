return {
  -- {
  --   "nvzone/showkeys",
  --   cmd = "ShowkeysToggle",
  --   opts = {
  --     timeout = 1,
  --     maxkeys = 5,
  --     -- more opts
  --   }
  -- },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  }
}
