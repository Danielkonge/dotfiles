return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    {
      "rcarriga/nvim-notify",
      opts = { background_colour = "#000000" }
    },
  },
  config = function()
    local noice = require("noice")
    noice.setup({
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = false,    -- use a classic bottom cmdline for search
        command_palette = false,  -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,       -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,   -- add a border to hover docs and signature help
      },
      messages = {
        enabled = true,
        view = "mini",
        view_error = "mini",
        view_warn = "mini",
        view_history = "messages",
        view_search = "virtualtext",
      }
    })

    vim.keymap.set("n", "<leader>nl", function()
      noice.cmd("last")
    end, { desc = '[N]oice [L]ast' }
    )

    vim.keymap.set("n", "<leader>nh", function()
      noice.cmd("history")
    end, { desc = '[N]oice [H]istory' }
    )

    vim.keymap.set("n", "<leader>nt", function()
      noice.cmd("telescope")
    end, { desc = '[N]oice [T]elescope' }
    )

    vim.keymap.set("n", "<leader>ns", function()
      noice.cmd("stats")
    end, { desc = '[N]oice [S]tats' }
    )

    vim.keymap.set("c", "<S-Enter>", function()
      noice.redirect(vim.fn.getcmdline)
    end, { desc = "Redirect Cmdline" })

    -- set up in cmp too:
    local noice_lsp = require("noice.lsp")
    vim.keymap.set({ "n", "s", "i" }, "<C-.>", function()
      if not noice_lsp.scroll(4) then
        return "<C-.>" -- "<C-.>"
      end
    end, { silent = true, expr = true })

    vim.keymap.set({ "n", "s", "i" }, "<C-,>", function()
      if not noice_lsp.scroll(-4) then
        return "<C-,>"-- "<C-,>"
      end
    end, { silent = true, expr = true })
  end,
}
