-- Bootstrap packer
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Autoreload nvim on save
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', { command = 'source <afile> | PackerCompile', group = packer_group, pattern = 'init.lua' })

require('packer').startup({function()
  -- Package manager
  use 'wbthomason/packer.nvim'
  
  use { 'bluz71/vim-moonfly-colors',
    config = function()
      vim.opt.termguicolors = true

      vim.g.moonflyCursorColor = 1
      vim.g.moonflyTransparent = 1
      vim.g.moonflyUnderlineMatchParen = 1
      vim.g.moonflyWinSeparator = 2
      vim.opt.fillchars = { horiz = '━', horizup = '┻', horizdown = '┳', vert = '┃', vertleft = '┫', vertright = '┣', verthoriz = '╋', }

      vim.cmd [[colorscheme moonfly]]
    end
  }

  use 'preservim/nerdtree'

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use 'nvim-lua/plenary.nvim'
  use 'mfussenegger/nvim-dap'

  -- LSP
  use 'neovim/nvim-lspconfig'

  use {
    'nvim-telescope/telescope.nvim',
    { 
      'nvim-telescope/telescope-ui-select.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    },
    config = function()
      local telescope = require('telescope')
      telescope.load_extension('ui-select')
      telescope.load_extension('fzf')
    end
  }

  -- completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-nvim-lsp-signature-help',
    },
    config = function() 
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<Tab>'] = cmp.mapping(
            function(fallback)
              -- local copilot_keys = vim.fn['copilot#Accept']()
              if cmp.visible() then
                cmp.select_next_item()
                --elseif luasnip.expand_or_jumpable() then
                --luasnip.expand_or_jump()
              -- elseif copilot_keys ~= '' and type(copilot_keys) == 'string' then
              --  vim.api.nvim_feedkeys(copilot_keys, 'i', true)
              else
                fallback()
              end
            end, 
            { 'i', 's' }
          ),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
          ['<C-g>'] = cmp.mapping(
            function(fallback)
              local copilot_keys = vim.fn['copilot#Accept']()
              if copilot_keys ~= '' and type(copilot_keys) == 'string' then
                vim.api.nvim_feedkeys(copilot_keys, 'i', true)
              else
                fallback()
              end
            end
          ),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'vsnip' },
          { name = 'path' },
          { name = 'buffer' },
        },
        experimental = {
          ghost_text = false,
        },
      })
    end
  }

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        highlight = {
          enable = true, -- false will disable the whole extension
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
          },
        },
        indent = {
          enable = true,
        },
      })
    end
  }

  use 'junegunn/goyo.vim' -- Minimal editor mode
  use 'tpope/vim-fugitive' -- Git

  -- Status bar
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = 'moonfly',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {},
          always_divide_middle = true,
          globalstatus = false,
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        extensions = {}
      })
    end,
  }

  -- Rust additional
  use 'simrat39/rust-tools.nvim'

  -- Git Sign on side
  use { 'lewis6991/gitsigns.nvim', -- git added/removed in sidebar + inline blame
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup({
        current_line_blame = false,
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        }
      })
    end
  }

  -- use {
  --   'github/copilot.vim',
  --   config = function()
  --     --vim.g.copilot_no_tab_map = true
  --     vim.g.copilot_assume_mapped = true
  --     vim.g.copilot_tab_fallback = ""
  --   end
  -- }

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end,
config = {
  profile = {
    enable = true,
    threshold = 1,
  }
}})

vim.keymap.set({ 'n', 'v' }, '<Space>', '', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.ignorecase = true
vim.opt.smartcase  = true

-- Folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel  = 20

-- Number Column
vim.opt.relativenumber = true
vim.opt.signcolumn     = 'number'

-- Tabs
vim.opt.tabstop     = 2
vim.opt.softtabstop = -1
vim.opt.shiftwidth  = 0
vim.opt.shiftround  = true
vim.opt.expandtab   = true
vim.opt.smarttab    = true

-- Interface
vim.opt.title = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.laststatus = 3

vim.opt.undofile = true

vim.opt.completeopt = 'menuone,noinsert,noselect'

vim.opt.laststatus = 3

-- Mappings
local opts = { noremap=true, silent=true }

-- Nerdtree
vim.keymap.set('n', '<Leader>n', ':NERDTreeToggle<CR>', opts)

vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, opts) 
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, opts) 
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts) 
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts) 

--Add leader shortcuts
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers)
vim.keymap.set('n', '<leader>sf', function()
  require('telescope.builtin').find_files { previewer = false }
end)
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').current_buffer_fuzzy_find)
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags)
vim.keymap.set('n', '<leader>st', require('telescope.builtin').tags)
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').grep_string)
vim.keymap.set('n', '<leader>sp', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>so', function()
  require('telescope.builtin').tags { only_current_buffer = true }
end)
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles)

local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- vim.keymap.set("v", "<C-space>", rt.hover_range.hover_range, { buffer = bufnr })
      vim.keymap.set("n", "<C-.>", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})
 
-- local on_attach = function(_, bufnr)
--   local opts = { buffer = bufnr }
--   vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
--   vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
--   vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
--   vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
--   vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
--   vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
--   vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
--   vim.keymap.set('n', '<leader>wl', function()
--     vim.inspect(vim.lsp.buf.list_workspace_folders())
--   end, opts)
--   vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
--   vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
--   vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
--   vim.keymap.set('n', '<leader>.', vim.lsp.buf.code_action, opts)
--   vim.keymap.set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, opts)
--   vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
-- 
--   vim.opt.updatetime = 300
--   vim.api.nvim_create_autocmd({"CursorHold"}, {
--     callback = function() vim.diagnostic.open_float(nil, { focusable = false }) end
--   })
-- end


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- local servers = { 'tsserver' }
-- for _, lsp in pairs(servers) do
--   require('lspconfig')[lsp].setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--   }
-- end

-- Example custom server
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
