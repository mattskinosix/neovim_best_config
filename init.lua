-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

local use = require('packer').use
require('packer').startup(function()
  use { 'renerocksai/telekasten.nvim' }
  use { 'renerocksai/calendar-vim' }
  use { 'vuciv/vim-bujo' }
  use {
    's1n7ax/nvim-terminal',
    config = function()
        vim.o.hidden = true
        require('nvim-terminal').setup()
    end,
  }
  use {
    "NTBBloodbath/rest.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("rest-nvim").setup({
        -- Open request results in a horizontal split
        result_split_horizontal = false,
        -- Skip SSL verification, useful for unknown certificates
        skip_ssl_verification = false,
        -- Highlight request on run
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result = {
          -- toggle showing URL, HTTP info, headers at top the of result window
          show_url = true,
          show_http_info = true,
          show_headers = true,
        },
        -- Jump to request line on run
        jump_to_request = false,
        env_file = '.env',
        custom_dynamic_variables = {},
        yank_dry_run = true,
      })
    end
  }
  use { "ellisonleao/gruvbox.nvim" }
  use 'Pocco81/AutoSave.nvim'
  use 'rbong/vim-flog'
  use { 'tpope/vim-surround' }
  use 'mg979/vim-visual-multi'
  use 'wbthomason/packer.nvim' -- Package manager
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
  -- UI to select things (files, grep results, open buffers...)
  use { "nvim-lua/plenary.nvim" }
  use { "nvim-lua/popup.nvim" }
  use { "nvim-telescope/telescope.nvim" }
  use 'voldikss/vim-browser-search'
  use {'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim'}
  use { "nvim-telescope/telescope-media-files.nvim" }
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
  use 'christoomey/vim-conflicted'
  use { 'rottencandy/vimkubectl' }
  use {
        "hrsh7th/nvim-cmp",
        requires = {
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-nvim-lsp",
          "quangnguyen30192/cmp-nvim-ultisnips",
          "hrsh7th/cmp-nvim-lua",
          "octaltree/cmp-look",
          "hrsh7th/cmp-path",
          "hrsh7th/cmp-calc",
          "f3fora/cmp-spell",
          "hrsh7th/cmp-emoji",
          "ray-x/cmp-treesitter",
          "hrsh7th/cmp-cmdline",
          "hrsh7th/cmp-nvim-lsp-document-symbol",
        },
      }
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'ms-jpq/chadtree'
  use 'windwp/nvim-autopairs'
  use 'kristijanhusak/vim-dadbod'
  use 'kristijanhusak/vim-dadbod-ui'
  use 'kristijanhusak/vim-dadbod-completion'
  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}
  use 'idanarye/vim-merginal'
  use('MunifTanjim/prettier.nvim')
  use { "nvim-telescope/telescope-arecibo.nvim",
        rocks = {"openssl", "lua-http-parser"}}
  use {'jeffkreeftmeijer/vim-numbertoggle'}
  use {
      "rcarriga/nvim-notify",
      event = "VimEnter",
      config = function()
        vim.notify = require "notify"
      end,
  }
  -- Lua
  use { "RRethy/vim-illuminate" }
  use { "windwp/windline.nvim" }
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use 'glepnir/dashboard-nvim'
  use 'airblade/vim-rooter'
end)

-- ####################################################################################################################################################################################
--                                                                        WILDLINE
-- ####################################################################################################################################################################################
local windline = require('windline')
require('wlsample.airline_luffy')
    --- you need to define your status lines here

-- ####################################################################################################################################################################################
--                                                                        BLANKLINE
-- ####################################################################################################################################################################################
vim.opt.list = true
vim.opt.listchars:append("space:???")
vim.opt.listchars:append("eol:???")

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
-- ####################################################################################################################################################################################
--                                                                          DBUI
-- ####################################################################################################################################################################################
vim.g.dev= 'postgres://postgres:password@localhost:10000/postgres'
vim.cmd [[ autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} }) ]]

-- ####################################################################################################################################################################################
--                                                                          TELESCOPE
-- ####################################################################################################################################################################################

vim.g.dashboard_default_executive = 'telescope'

-- ####################################################################################################################################################################################
--                                                                          ROOTER
-- ####################################################################################################################################################################################
vim.g.rooter_pattern ={'.git', '.skaffold', '.kubernetes', '.gitlab', '.coveragerc', '.coveragerc'}
vim.g.rooter_manual_only = 1
-- ####################################################################################################################################################################################
--                                                                           LSP
-- ####################################################################################################################################################################################

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- ####################################################################################################################################################################################
--                                                                           CMP
-- ####################################################################################################################################################################################

local cmp = require 'cmp'
-- nvim-cmp setup
cmp.setup.cmdline(":", {
    sources = {
      { name = "cmdline" },
    },
})
-- lsp_document_symbols
cmp.setup.cmdline('/', {
    sources = cmp.config.sources({
      { name = 'nvim_lsp_document_symbol' }
    }, {
      { name = 'buffer' }
    })
})

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
  },
}


-- ####################################################################################################################################################################################
--                                                                           NPAIRS
-- ####################################################################################################################################################################################

local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')


-- you can use some built-in conditions

local cond = require('nvim-autopairs.conds')

npairs.setup({
    check_ts = true,
    ts_config = {
        lua = {'string'},-- it will not add a pair on that treesitter node
        javascript = {'template_string'},
        java = false,-- don't check treesitter on java
    }
})

local ts_conds = require('nvim-autopairs.ts-conds')



-- press % => %% only while inside a comment or string
npairs.add_rules({
  Rule("%", "%", "lua")
    :with_pair(ts_conds.is_ts_node({'string','comment'})),
  Rule("$", "$", "lua")
    :with_pair(ts_conds.is_not_ts_node({'function'}))
})


-- ####################################################################################################################################################################################
--                                                                           VARIUS SETTING
-- ####################################################################################################################################################################################

--Set highlight on search
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.cmd [[colorscheme gruvbox]]
-- ####################################################################################################################################################################################
--                                                                           STATUSBAR
-- ####################################################################################################################################################################################

--Set statusbar
vim.g.lightline = {
  colorscheme = 'gruvbox',
  active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
  component_function = { gitbranch = 'fugitive#head' },
}
-- ####################################################################################################################################################################################
--                                                                           LEADER
-- ####################################################################################################################################################################################


--Remap space as leader key
vim.api.nvim_set_keymap('', ',', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- ####################################################################################################################################################################################
--                                                                           LSP
-- ####################################################################################################################################################################################

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '???' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}
-- ####################################################################################################################################################################################
--                                                                           TELESCOPE
-- ####################################################################################################################################################################################

-- Telescope
require('telescope').load_extension('arecibo')
require('telescope').load_extension('media_files')
require('telescope').setup {
   extensions = {
    arecibo = {
      selected_engine   = 'duckduckgo',
      url_open_command = 'xdg-open',
      show_http_headers = false,
      show_domain_icons = true,
    },
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = {"png", "webp", "jpg", "jpeg"},
      find_cmd = "rg" -- find command (defaults to `fd`)
    }
  }
}

-- ####################################################################################################################################################################################
--                                                                           TREESITTER
-- ####################################################################################################################################################################################
-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  indent = {
    enable = true
  },
  incremental_selection = {
    enable = true,  
    autotag = {
      enable = true,
    },
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatic/ally jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- ####################################################################################################################################################################################
--                                                                           MAPPING
-- ####################################################################################################################################################################################

--Add leader shortcuts
vim.api.nvim_set_keymap('n', '<leader>b', [[<Plug>Merginal]], { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>r', [[<Plug>RestNvim]], { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>d', [[<cmd>CHADopen<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>g', [[<cmd>Git<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>w', [[<cmd>w<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fbg', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ft', [[<cmd>lua require('telescope.builtin').tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ws', [[<Plug>BrowserSeach ]], { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>ci', [[<Plug>BujoAddnormal]], { noremap = false, silent = true })

vim.api.nvim_set_keymap('n', '<leader>cc', [[<Plug>BujoChecknormal]], { noremap = false, silent = true })

vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>",
  {silent = true, noremap = true}
)
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  require 'illuminate'.on_attach(client)
end



-- ####################################################################################################################################################################################
--                                                                           LSP
-- ####################################################################################################################################################################################
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local border = {
      {"????", "FloatBorder"},
      {"???", "FloatBorder"},
      {"????", "FloatBorder"},
      {"???", "FloatBorder"},
      {"????", "FloatBorder"},
      {"???", "FloatBorder"},
      {"????", "FloatBorder"},
      {"???", "FloatBorder"},
}

-- LSP settings (for overriding per client)
local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}


local servers = { 'pyright', 'pylsp', 'rust_analyzer', 'tsserver', 'eslint', 'vuels', 'sqlls', 'cssls', 'dockerls', 'yamlls', 'html',  'angularls'}
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    handlers=handlers,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end

require('lspconfig').yamlls.setup {
 -- other configuration for setup {}
  settings = {
    yaml = {
  -- other settings. note this overrides the lspconfig defaults.
      schemas = {
        ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.yaml",
        ["https://raw.githubusercontent.com/GoogleContainerTools/skaffold/main/docs/content/en/schemas/v2beta20.json"] = "/*skaffold.yaml",
        -- other schemas
      },
    },
  }
}
-- Do not forget to use the on_attach function
-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
})
-- ####################################################################################################################################################################################
--                                                                           FLUTTER
-- ####################################################################################################################################################################################

require("flutter-tools").setup{}
-- ####################################################################################################################################################################################
--                                                                           Prettier
-- ####################################################################################################################################################################################
local prettier = require("prettier")



prettier.setup({
  bin = 'prettier', -- or `prettierd`
  filetypes = {
    "python",
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
    "vue"
  },

  -- prettier format options (you can use config files too. ex: `.prettierrc`)
  arrow_parens = "always",
  bracket_spacing = true,
  embedded_language_formatting = "auto",
  end_of_line = "lf",
  html_whitespace_sensitivity = "css",
  jsx_bracket_same_line = false,
  jsx_single_quote = false,
  print_width = 80,
  prose_wrap = "preserve",
  quote_props = "as-needed",
  semi = true,
  single_quote = false,
  tab_width = 2,
  trailing_comma = "es5",
  use_tabs = false,
  vue_indent_script_and_style = true,
})


-- ####################################################################################################################################################################################
--                                                                           bufferline
-- ####################################################################################################################################################################################
vim.opt.termguicolors = true

require("bufferline").setup{
  options = {
    numbers = "ordinal",
    max_name_length = 18,
    separator_style = "slant",
    tab_size = 18,
    show_buffer_icons = true,
    custom_filter = function(buf_number)
        if vim.fn.bufname(buf_number) ~= "Merginal" and vim.fn.bufname(buf_number) ~= "index" then
          return true
        end
    end,
    offsets = {{filetype = "CHADTree", text = "File Explorer" },{filetype = "fugitive", text = "Git" },{filetype = "fish", text = "terminal" }},
    sort_by =  'directory'
  }
}


-- ####################################################################################################################################################################################
--                                                                           VIM
-- ####################################################################################################################################################################################

vim.cmd[[filetype plugin indent on]]
vim.cmd[[set expandtab]]
vim.o.tabstop=2
vim.o.softtabstop=2
vim.o.shiftwidth=2
vim.cmd[[set nocompatible]]
vim.cmd[[xnoremap p pgvy]]


-- ####################################################################################################################################################################################
--                                                                           autosave
-- ####################################################################################################################################################################################


require('autosave').setup(
    {
        enabled = true,
        execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
        events = {"TextChanged", "InsertLeave"},
        conditions = {
            exists = true,
            filename_is_not = {},
            filetype_is_not = {},
            modifiable = true
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0
    }
)
