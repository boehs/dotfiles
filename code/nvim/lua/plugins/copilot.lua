-- Copilot.
return {
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end
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
