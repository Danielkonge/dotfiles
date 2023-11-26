-- lualine.lua

---@type boolean
vim.g.show_macro_in_lualine = true

vim.keymap.set('n', '<leader>tm',
    function()
        vim.g.show_macro_in_lualine = not vim.g.show_macro_in_lualine
    end, { desc = 'Toggle [M]acro in Lualine' })

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
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

                shorting_target = 20, -- Shortens path to leave 40 spaces in the window
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
            -- {
            --     require("noice").api.status.message.get_hl,
            --     cond = require("noice").api.status.message.has,
            -- },
            {
                require("noice").api.status.command.get,
                cond = require("noice").api.status.command.has,
                color = { fg = "#ff9e64" },
            },
            -- {
            --     require("noice").api.status.mode.get,
            --     cond = require("noice").api.status.mode.has,
            --     color = { fg = "#ff9e64" },
            -- },
            {
                require("noice").api.status.search.get,
                cond = require("noice").api.status.search.has,
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
        'quickfix',
        'man',
        'mason',
        'trouble',
        'lazy',
    }
}
