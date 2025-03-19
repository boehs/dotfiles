-- Copilot.
return {
  {
    "olimorris/codecompanion.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("codecompanion").setup({
        stratagies = {
          chat = {
            adapter = "copilot",
          },
          inline = {
            adapter = "copilot",
          },
        },
      })

      vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "giuxtaposition/blink-cmp-copilot",
    after = { "copilot.lua" },
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      panel = { enabled = false },
      -- Disable to use in cmp
      suggestion = { enabled = false },
    },
    config = function(_, opts)
      require('copilot').setup(opts)
    end,
  },
}
