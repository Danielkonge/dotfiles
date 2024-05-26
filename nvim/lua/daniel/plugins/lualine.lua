---@type boolean
vim.g.show_macro_in_lualine = true

---@type boolean
vim.g.change_lualine_theme_colors = true

vim.keymap.set('n', '<leader>tm',
  function()
    vim.g.show_macro_in_lualine = not vim.g.show_macro_in_lualine
  end, { desc = 'Toggle [M]acro in Lualine' })

vim.keymap.set('n', '<leader>to',
  function()
    local stdout = vim.loop.new_tty(1, false)
    if stdout and vim.g.change_lualine_theme_colors then
      stdout:write(
        ('\x1b]1337;SetUserVar=%s=%s\b\x1b\\'):format(
          'OPACITY_MODE',
          vim.fn.system({ "base64" }, '1')
        )
      )
    elseif stdout then
      stdout:write(
        ('\x1b]1337;SetUserVar=%s=%s\b\x1b\\'):format(
          'OPACITY_MODE',
          vim.fn.system({ "base64" }, '-1')
        )
      )
    end
    vim.g.change_lualine_theme_colors = not vim.g.change_lualine_theme_colors

    local custom_onedark = require('lualine.themes.onedark')
    if vim.g.change_lualine_theme_colors then
      -- onedark (deep) has fg color #93a4c3
      custom_onedark.normal.a.fg = '#93a4c3'
      custom_onedark.visual.a.fg = '#93a4c3'
      custom_onedark.replace.a.fg = '#93a4c3'
      custom_onedark.insert.a.fg = '#93a4c3'
      custom_onedark.command.a.fg = '#93a4c3'
      custom_onedark.terminal.a.fg = '#93a4c3'
    else
      -- onedark (deep) has bg0 color #1a212e
      custom_onedark.normal.a.fg = '#1a212e'
      custom_onedark.visual.a.fg = '#1a212e'
      custom_onedark.replace.a.fg = '#1a212e'
      custom_onedark.insert.a.fg = '#1a212e'
      custom_onedark.command.a.fg = '#1a212e'
      custom_onedark.terminal.a.fg = '#1a212e'
    end
    require('lualine').setup({ options = { theme = custom_onedark } })
    vim.cmd([[redraw]])
  end, { desc = 'Toggle Wezterm Text [O]pacity' })


return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'navarasu/onedark.nvim',
  },
  -- See `:help lualine.txt`
  config = function()
    local custom_onedark = require('lualine.themes.onedark')
    -- onedark (deep) has fg color #93a4c3
    custom_onedark.normal.a.fg = '#93a4c3'
    custom_onedark.visual.a.fg = '#93a4c3'
    custom_onedark.replace.a.fg = '#93a4c3'
    custom_onedark.insert.a.fg = '#93a4c3'
    custom_onedark.command.a.fg = '#93a4c3'
    custom_onedark.terminal.a.fg = '#93a4c3'

    local gitblame = require('gitblame')
    local noice = require('noice')
    require('lualine').setup({
      options = {
        icons_enabled = true,
        -- theme = 'auto',
        theme = custom_onedark,
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_c = {
          {
            'filename',
            file_status = true,     -- Displays file status (readonly status, modified status)
            newfile_status = false, -- Display new file status (new file means no write after created)
            path = 3,               -- 0: Just the filename
            -- 1: Relative path
            -- 2: Absolute path
            -- 3: Absolute path, with tilde as the home directory
            -- 4: Filename and parent dir, with tilde as the home directory

            shorting_target = 20, -- Shortens path to leave 20 spaces in the window
            -- for other components. (terrible name, any suggestions?)
            symbols = {
              modified = '[+]',      -- Text to show when the file is modified.
              readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[No Name]', -- Text to show for unnamed buffers.
              newfile = '[New]',     -- Text to show for newly created file before first write
            }
          },
        },
        lualine_x = {
          {
            gitblame.get_current_blame_text,
            cond = gitblame.is_blame_text_available
          },
          -- {
          --     require("noice").api.status.message.get_hl,
          --     cond = require("noice").api.status.message.has,
          -- },
          {
            noice.api.status.command.get,
            cond = noice.api.status.command.has,
            color = { fg = "#ff9e64" },
          },
          -- {
          --     require("noice").api.status.mode.get,
          --     cond = require("noice").api.status.mode.has,
          --     color = { fg = "#ff9e64" },
          -- },
          {
            noice.api.status.search.get,
            cond = noice.api.status.search.has,
            color = { fg = "#ff9e64" },
          },

          {
            function() return 'Recording macro to: @' .. vim.fn.reg_recording() end,
            cond = function()
              return vim.fn.reg_recording() ~= ''
                  and vim.g.show_macro_in_lualine
            end,
            color = { fg = 'ff9e64' },
          },

          {
            function() return 'Last macro: @' .. vim.fn.reg_recorded() end,
            cond = function()
              return vim.fn.reg_recording() == ''
                  and vim.fn.reg_recorded() ~= ''
                  and vim.fn.reg_executing() == ''
                  and vim.g.show_macro_in_lualine
            end
          },

          {
            function() return 'Current macro: @' .. vim.fn.reg_executing() end,
            cond = function()
              return vim.fn.reg_recording() == ''
                  and vim.fn.reg_recorded() ~= ''
                  and vim.fn.reg_executing() ~= ''
                  and vim.g.show_macro_in_lualine
            end
          },
          'encoding', 'fileformat', 'filetype'
        },
      },
      extensions = {
        'aerial',
        'quickfix',
        'man',
        'mason',
        'trouble',
        'lazy',
        'oil',
      }
    })
  end,
}
