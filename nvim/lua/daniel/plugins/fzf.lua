return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require('fzf-lua')

    local winopts = {
      height = 0.9,
      width = 0.9,
      backdrop = 100,
      fullscreen = false,
    }

    local keymap = {
      builtin = {
        ["?"] = "toggle-help",
        ["<C-w>"] = "toggle-preview-wrap",
        ["<C-o>"] = "toggle-preview",
        ["<C-d>"] = "preview-page-down",
        ["<C-u>"] = "preview-page-up",
        ["<C-e>"] = "preview-up",
        ["<C-y>"] = "preview-down",
      },
      fzf = {
        ["ctrl-q"] = "select-all+accept",
      },
    }

    local files = {
      hidden = true,
      follow = true,
      no_ignore = false,
    }


    fzf.setup({
      winopts = winopts,
      keymap = keymap,
      files = files,
    })
    fzf.register_ui_select()


    -- Buffers and files
    vim.keymap.set('n', '<leader>sb', fzf.buffers, { desc = '[S]earch [B]uffers' })
    vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[S]earch [F]iles in cwd' })
    vim.keymap.set('n', '<leader>sF', function()
      fzf.files({
        cwd = '~',
        cmd = [[fd --color=never --hidden --type d --type l --follow --exclude .git]],
        previewer = nil,
        preview = {
          type = 'cmd',
          fn = function(selected)
            local relative_path = fzf.path.entry_to_file(selected[1], {}, false).path
            local path = vim.fs.joinpath('~', relative_path)
            return string.format('tree -C -L 1 %s', path)
          end,
        },
        prompt = 'Directories❯ ',
        actions = {
          ["enter"] = function(selected)
            local relative_path = fzf.path.entry_to_file(selected[1], {}, false).path
            local path = vim.fs.joinpath('~', relative_path)
            fzf.files({
              cwd = path,
            })
          end,
        },
      })
    end, { desc = '[S]earch [F]iles in chosen directory' })


    -- Search (grep)
    vim.keymap.set('n', '<leader>/', fzf.blines, { desc = '[/] Grep in current buffer' })
    vim.keymap.set('n', '<leader>s/', fzf.lines, { desc = '[/] Grep in open buffers' })
    vim.keymap.set('n', '<leader>*', fzf.grep_cword, { desc = '[*] Grep word under cursor' })
    vim.keymap.set('v', '<leader>*', fzf.grep_visual, { desc = '[*] Grep word under cursor' })
    vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = '[G]rep in cwd' })
    vim.keymap.set('n', '<leader>sG', function()
      fzf.files({
        cwd = '~',
        cmd = [[fd --color=never --hidden --type d --type l --follow --exclude .git]],
        previewer = nil,
        preview = {
          type = 'cmd',
          fn = function(selected)
            local relative_path = fzf.path.entry_to_file(selected[1], {}, false).path
            local path = vim.fs.joinpath('~', relative_path)
            return string.format('tree -C -L 1 %s', path)
          end,
        },
        prompt = 'Directories❯ ',
        actions = {
          ["enter"] = function(selected)
            local relative_path = fzf.path.entry_to_file(selected[1], {}, false).path
            local path = vim.fs.joinpath('~', relative_path)
            fzf.live_grep({
              cwd = path,
            })
          end,
        },
      })
    end, { desc = '[G]rep in chosen directory' })


    -- Git
    vim.keymap.set('n', '<leader>gs', fzf.git_status, { desc = '[S]earch [G]it status' })


    -- Diagnostics
    vim.keymap.set('n', '<leader>sd', fzf.diagnostics_document, { desc = '[S]earch document [D]iagnostics' })
    vim.keymap.set('n', '<leader>sD', fzf.diagnostics_workspace, { desc = '[S]earch workspace [D]iagnostics' })
    vim.keymap.set('n', '<leader>ds', fzf.diagnostics_document, { desc = '[S]earch document [D]iagnostics' })
    vim.keymap.set('n', '<leader>dS', fzf.diagnostics_workspace, { desc = '[S]earch workspace [D]iagnostics' })

    -- LSP
    vim.keymap.set('n', 'gr', fzf.lsp_references, { desc = 'LSP: [G]oto [R]eferences' })
    vim.keymap.set('n', 'gd', fzf.lsp_definitions, { desc = 'LSP: [G]oto [D]efinitions' })
    vim.keymap.set('n', 'gD', fzf.lsp_declarations, { desc = 'LSP: [G]oto [D]eclarations' })
    vim.keymap.set('n', 'gi', fzf.lsp_implementations, { desc = 'LSP: [G]oto [I]mplementations' })
    vim.keymap.set('n', 'gt', fzf.lsp_typedefs, { desc = 'LSP: [T]ype definitions' })

    vim.keymap.set('n', '<leader>ca', fzf.lsp_code_actions, { desc = 'LSP: [C]ode [A]ctions' })

    -- less common lsp commands
    vim.keymap.set('n', '<leader>ld', fzf.lsp_document_symbols, { desc = 'LSP: [D]ocument symbols' })
    vim.keymap.set('n', '<leader>lw', fzf.lsp_live_workspace_symbols, { desc = 'LSP: [W]orkspace symbols' })
    vim.keymap.set('n', '<leader>li', fzf.lsp_incoming_calls, { desc = 'LSP: [I]ncoming calls' })
    vim.keymap.set('n', '<leader>lo', fzf.lsp_outgoing_calls, { desc = 'LSP: [O]outgoing calls' })


    -- Misc
    vim.keymap.set('n', '<leader>sr', fzf.registers, { desc = '[S]earch [R]egisters' })
    vim.keymap.set('n', '<leader>ss', function()
      fzf.spell_suggest({ winopts = { height = 0.33, width = 0.33, relative = "cursor" } })
    end, { desc = '[S]earch [S]pell suggestion' })
    vim.keymap.set('n', '<leader>sp', function()
      fzf.complete_path({
        cmd = [[fd --color=never --hidden --type d --type f --type l --follow]],
        previewer = nil,
        fzf_opts = {
          ["--preview"] = 'bat --color=always --style=numbers,changes {} 2> /dev/null || tree -C -L 1 {}',
        },
      })
    end, { desc = '[S]earch [P]ath' })
  end,
}
