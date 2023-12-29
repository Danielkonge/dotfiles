-- todo.lua

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
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
