return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'navarasu/onedark.nvim',
  },
  -- See `:help lualine.txt`
  config = function()
    local custom_onedark = require('lualine.themes.onedark')

    local gitblame = require('gitblame')
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

            shorting_target = 40, -- Shortens path to leave 20 spaces in the window
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
          --   function() return 'Recording macro to: @' .. vim.fn.reg_recording() end,
          --   cond = function()
          --     return vim.fn.reg_recording() ~= ''
          --   end,
          --   color = { fg = 'ff9e64' },
          -- },
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
