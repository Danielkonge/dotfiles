return {
  "olimorris/codecompanion.nvim",
  version = "^19.0.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local codecompanion = require("codecompanion")
    codecompanion.setup({
      interactions = {
        -- chat = {
        --   adapter = "anthropic",
        --   model = "eu.anthropic.claude-sonnet-4-5-20250929-v1:0"
        -- },
        cli = {
          agent = "claude_code_bedrock",
          agents = {
            claude_code_bedrock = {
              cmd = "claude",
              args = {},
              description = "Claude Code CLI",
              provider = "terminal",
            }
          }
        },
      },
    })
  end
}
