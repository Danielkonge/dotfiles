return {
  {
    -- "gc" to comment visual regions/lines
    'numToStr/Comment.nvim',
    opts = {},
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local todo_comments = require("todo-comments")
      todo_comments.setup({
        highlight = {
          multiline = false,
          before = "",
          after = "",
        }
      })

      vim.keymap.set("n", "]t", function()
        todo_comments.jump_next()
      end, { desc = "Next todo comment" })

      vim.keymap.set("n", "[t", function()
        todo_comments.jump_prev()
      end, { desc = "Previous todo comment" })

      vim.api.nvim_set_keymap(
        "n",
        "<space>st",
        "<Cmd>TodoTelescope<CR>",
        { noremap = true, desc = '[S]earch [T]odo' }
      )

      vim.api.nvim_set_keymap(
        "n",
        "<space>xt",
        "<Cmd>TodoTrouble<CR>",
        { noremap = true, desc = 'Trouble [T]odos' }
      )
    end,
  },

  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      local neogen = require('neogen')
      neogen.setup({
        enabled = true,
        input_after_comment = true,
        snippet_engine = 'luasnip',
        languages = {
          lua = { template = { annotation_convention = 'emmylua' } },
          python = { template = { annotation_convention = 'google_docstrings' } },
          rust = { template = { annotation_convention = 'rustdoc' } },
          c = { template = { annotation_convention = 'doxygen' } },
          sh = { template = { annotation_convention = 'google_bash' } },
        }
      })

      vim.keymap.set('n', '<leader>Gg', neogen.generate, { silent = true, desc = '[G]enerate General Docs' })
      vim.keymap.set('n', '<leader>Gf', function() neogen.generate({ type = 'func' }) end,
        { silent = true, desc = '[G]enerate Function Docs' })
      vim.keymap.set('n', '<leader>Gc', function() neogen.generate({ type = 'class' }) end,
        { silent = true, desc = '[G]enerate Class Docs' })
      vim.keymap.set('n', '<leader>Gt', function() neogen.generate({ type = 'type' }) end,
        { silent = true, desc = '[G]enerate Type Docs' })
      vim.keymap.set('n', '<leader>GF', function() neogen.generate({ type = 'file' }) end,
        { silent = true, desc = '[G]enerate File Docs' })
    end,
  }
}
