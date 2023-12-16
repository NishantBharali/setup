-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "onedarker"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
vim.cmd [[let mapleader='\']]

-- https://www.lunarvim.org/configuration/02-keybindings.html#lunarvim-keybindings
-- use the default vim behavior for H and L
lvim.keys.insert_mode["<C-k>"] = nil
lvim.keys.normal_mode["<S-l>"] = nil
lvim.keys.normal_mode["<S-h>"] = nil
-- add your own keymapping
-- Emacs and bash style insert mode CTRL shortcuts
lvim.keys.normal_mode["ZA"] = ":xa<CR>"
lvim.keys.normal_mode["Y"] = "y$"
-- <C-a> = Move to start of the line; like in vim command mode: c_ctrl-b; To insert previously inserted text, use <C-r>. or <Alt-.> (below)
lvim.keys.insert_mode["<C-a>"] = "<Home>"
-- <C-b> = Move one character backward; the opposite of <C-f>
lvim.keys.insert_mode["<C-b>"] = "<Left>"
-- <C-d> = Delete one character forward; the opposite of <C-h>
vim.cmd [[inoremap <silent><expr> <C-d> "\<C-g>u<Delete>"]]
-- <C-e> = Move to end of the line (already exists in command mode: c_ctrl-e), this also cancels completion
lvim.keys.insert_mode["<C-e>"] = "<End>"
-- <C-f> = Move one character forward; the opposite of <C-b>; <C-f> is too useful (for : / ?) to remap
lvim.keys.insert_mode["<C-f>"] = "<Right>"
-- <C-g> = Cancel completion
vim.cmd [[inoremap <silent><expr> <C-g> pumvisible() ? "\<C-e>" :  "<C-g>"]]
-- <C-h> = Delete one character backward; the opposite of <C-d>; already exists in command mode: c_ctrl-h
vim.cmd [[inoremap <silent><expr> <C-h> "\<C-g>u<BS>"]]
-- <C-k> = Delete to end of line; the opposite of <C-u>; https://www.reddit.com/r/vim/comments/9i58q8/question_re_delete_word_forward_in_insert_mode/e6he226/; https://superuser.com/a/855997
vim.cmd [[inoremap <expr> <C-k> col(".") == col("$") ? "<Del>" : "<C-o>d$"]]
-- <C-r> = make paste from register undoable in insert mode; already exists in command mode: c_ctrl-r
vim.cmd [[inoremap <silent><expr> <C-r> "\<C-g>u<C-r>"]]
-- <C-u> = Delete to start of line; the opposite of <C-k>; already exists in command mode: c_ctrl-u
vim.cmd [[inoremap <silent><expr> <C-u> "\<C-g>u<C-u>"]]
-- <C-w> = Delete word backward; opposite of <A-d>; same as <A-h>; already exists in command mode: c_ctrl-w
vim.cmd [[inoremap <silent><expr> <C-w> "\<C-g>u<C-w>"]]
-- <C-y> = Paste from system clipboard (not from killring like in bash/emacs)
vim.cmd [[inoremap <silent> <C-y> <CR><C-r><C-o>"]]
-- <C-_> = Undo like in bash/emacs (this works really well)
lvim.keys.insert_mode["<C-_>"] = "<C-o>u"
-- <C-/> = Undo like in bash/emacs (this works really well)
lvim.keys.insert_mode["<C-/>"] = "<C-o>u"
-- <C-=> = Redo; opposite of <C-_>
lvim.keys.insert_mode["<C-=>"] = "<C-o><C-r>"
-- <A-a> = Move to previous sentence start ; opposite of <A-e>
lvim.keys.insert_mode["<A-a>"] = "<C-o>("
-- <A-b> = Move one word backward; opposite of <A-f>
lvim.keys.insert_mode["<A-b>"] = "<S-Left>"
-- <A-c> = Capitalize letter and move forward
vim.cmd [[inoremap <expr> <A-c> getline('.')[col('.')-1] =~ "\\s" ? "<C-o>W<C-o>gUl<C-o>l<C-o>guw<Esc>ea" : "<C-o>gUl<C-o>l<C-o>guw<Esc>ea"]]
-- <A-d> = Delete word forward; opposite of <A-h> and <C-w>; https://www.reddit.com/r/vim/comments/9i58q8/question_re_delete_word_forward_in_insert_mode/e6he226/
vim.cmd [[inoremap <expr> <A-d> col(".") == col("$") ? "<Del>" : "<C-o>de"]]
-- <A-e> = Move to previous sentence start ; opposite of <A-a>
lvim.keys.insert_mode["<A-e>"] = "<C-o>)"
-- <A-f> = Move one word forward; opposite of <A-b>
lvim.keys.insert_mode["<A-f>"] = "<S-Right>"
-- <A-l> = Lowercase to word end; opposite of <A-u>
lvim.keys.insert_mode["<A-l>"] = "<C-o>gue<Esc>ea"
-- <A-u> = Uppercase to word end; opposite of <A-l>
lvim.keys.insert_mode["<A-u>"] = "<C-o>gUe<Esc>ea"
-- <A-.> = Insert Previously Inserted text (if any)
lvim.keys.insert_mode["<A-.>"] = "<C-r>."
-- 2-character Sneak (default)
lvim.keys.normal_mode["<A-s>"] = "<Plug>Sneak_s"
lvim.keys.normal_mode["<A-S>"] = "<Plug>Sneak_S"
-- visual-mode
lvim.keys.visual_mode["<A-s>"] = "<Plug>Sneak_s"
lvim.keys.visual_mode["<A-S>"] = "<Plug>Sneak_S"

-- repeat motion
vim.cmd [[map ; <Plug>Sneak_;]]
vim.cmd [[map , <Plug>Sneak_,]]

-- 1-character enhanced 'f'
vim.cmd [[nmap f <Plug>Sneak_f]]
vim.cmd [[nmap F <Plug>Sneak_F]]
-- visual-mode
vim.cmd [[xmap f <Plug>Sneak_f]]
vim.cmd [[xmap F <Plug>Sneak_F]]
-- operator pending mode
vim.cmd [[omap f <Plug>Sneak_f]]
vim.cmd [[omap F <Plug>Sneak_F]]

-- 1-character enhanced 't'
vim.cmd [[nmap t <Plug>Sneak_t]]
vim.cmd [[nmap T <Plug>Sneak_T]]
-- visual-mode
vim.cmd [[xmap t <Plug>Sneak_t]]
vim.cmd [[xmap T <Plug>Sneak_T]]
-- operator pending mode
vim.cmd [[omap t <Plug>Sneak_t]]
vim.cmd [[omap T <Plug>Sneak_T]]

-- make vim-easymotion match spacemacs and doom emacs
vim.cmd [[nmap gs <Plug>(easymotion-prefix)]]
vim.cmd [[xmap gsf <Plug>(easymotion-f)]]
vim.cmd [[omap gsf <Plug>(easymotion-f)]]
vim.cmd [[xmap gsF <Plug>(easymotion-F)]]
vim.cmd [[omap gsF <Plug>(easymotion-F)]]
vim.cmd [[xmap gst <Plug>(easymotion-t)]]
vim.cmd [[omap gst <Plug>(easymotion-t)]]
vim.cmd [[xmap gsT <Plug>(easymotion-T)]]
vim.cmd [[omap gsT <Plug>(easymotion-T)]]
vim.cmd [[xmap gsw <Plug>(easymotion-w)]]
vim.cmd [[omap gsw <Plug>(easymotion-w)]]
vim.cmd [[xmap gsW <Plug>(easymotion-W)]]
vim.cmd [[omap gsW <Plug>(easymotion-W)]]
vim.cmd [[xmap gsb <Plug>(easymotion-b)]]
vim.cmd [[omap gsb <Plug>(easymotion-b)]]
vim.cmd [[xmap gsB <Plug>(easymotion-B)]]
vim.cmd [[omap gsB <Plug>(easymotion-B)]]
vim.cmd [[xmap gse <Plug>(easymotion-e)]]
vim.cmd [[omap gse <Plug>(easymotion-e)]]
vim.cmd [[xmap gsE <Plug>(easymotion-E)]]
vim.cmd [[omap gsE <Plug>(easymotion-E)]]
vim.cmd [[xmap gsge <Plug>(easymotion-ge)]]
vim.cmd [[omap gsge <Plug>(easymotion-ge)]]
vim.cmd [[xmap gsgE <Plug>(easymotion-gE)]]
vim.cmd [[omap gsgE <Plug>(easymotion-gE)]]
vim.cmd [[xmap gsj <Plug>(easymotion-j)]]
vim.cmd [[omap gsj <Plug>(easymotion-j)]]
vim.cmd [[xmap gsk <Plug>(easymotion-k)]]
vim.cmd [[omap gsk <Plug>(easymotion-k)]]
vim.cmd [[xmap gsn <Plug>(easymotion-n)]]
vim.cmd [[omap gsn <Plug>(easymotion-n)]]
vim.cmd [[xmap gsN <Plug>(easymotion-N)]]
vim.cmd [[omap gsN <Plug>(easymotion-N)]]
vim.cmd [[xmap gss <Plug>(easymotion-f2)]]
vim.cmd [[omap gss <Plug>(easymotion-f2)]]
vim.cmd [[xmap gsS <Plug>(easymotion-F2)]]
vim.cmd [[omap gsS <Plug>(easymotion-F2)]]

vim.cmd [[vmap gy <Plug>(Exchange)]]
vim.cmd [[nmap gy <Plug>(Exchange)]]

-- https://github.com/unblevable/quick-scope#highlight-on-key-press
-- vim.g.qs_highlight_on_keys = ['f', 'F', 't', 'T']
vim.g.EasyMotion_startofline = 0 -- keep cursor column when JK motion
vim.g.EasyMotion_smartcase = 1
vim.g.EasyMotion_use_smartsign_us = 1

vim.g.textobj_entire_no_default_key_mappings = 1

lvim.keys.normal_mode["yog"] = ":Gitsigns toggle_signs<CR>"
lvim.keys.normal_mode["yon"] = ":setlocal number!<CR>"
lvim.keys.normal_mode["yor"] = ":setlocal relativenumber!<CR>"
lvim.keys.normal_mode["yow"] = ":setlocal wrap!<CR>"
vim.cmd [[nnoremap <expr> yoa &fo =~ 'a' ? ':set fo-=a<CR>' : ':set fo+=a<CR>']]

vim.cmd [[onoremap ag	<Plug>(textobj-entire-a)]]
vim.cmd [[onoremap ig	<Plug>(textobj-entire-i)]]
vim.cmd [[xnoremap ag	<Plug>(textobj-entire-a)]]
vim.cmd [[xnoremap ig	<Plug>(textobj-entire-i)]]


-- https://www.lunarvim.org/configuration/02-keybindings.html#cursor-movement
lvim.line_wrap_cursor_movement = true
-- vim.opt.scrolloff = 0 -- Required so L moves to the last line
-- lvim.keys.insert_mode["<C-k>"] = "<C-\>estrpart(getcmdline(),0,getcmdpos()-1)<CR>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
-- set keymap with custom opts
-- lvim.keys.insert_mode["po"] = {'<ESC>', { noremap = true }}

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- lvim.builtin.telescope.on_config_done = function()
--   local actions = require "telescope.actions"
--   -- for input mode
--   lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
--   lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
--   lvim.builtin.telescope.defaults.mappings.i["<C-n>"] = actions.cycle_history_next
--   lvim.builtin.telescope.defaults.mappings.i["<C-p>"] = actions.cycle_history_prev
--   -- for normal mode
--   lvim.builtin.telescope.defaults.mappings.n["<C-j>"] = actions.move_selection_next
--   lvim.builtin.telescope.defaults.mappings.n["<C-k>"] = actions.move_selection_previous
-- end

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnosticss" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnosticss" },
-- }

-- Configure builtin plugins
-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
-- lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
-- lvim.builtin.nvimtree.show_icons.git = 0

-- Treesitter parsers change this to a table of the languages you want i.e. {"java", "python", javascript}
-- lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true




-- Disable virtual text
-- lvim.lsp.diagnostics.virtual_text = false
-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end

-- set a formatter if you want to override the default lsp one (if it exists)
-- lvim.lang.python.formatters = {
--   {
--     exe = "black",
--     args = {}
--   }
-- }
-- -- set an additional linter
-- lvim.lang.python.linters = {
--   {
--     exe = "flake8",
--     args = {}
--   }
-- }

-- Additional Plugins
lvim.plugins = {
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = {"fugitive"}
  },
  {
    "tpope/vim-surround",
    keys = {"c", "d", "y"}
  },
  {"tpope/vim-speeddating"},
  {"tpope/vim-repeat"},
  {"tpope/vim-unimpaired"},
  {"tommcdo/vim-exchange"},
  {"inkarkat/vim-ReplaceWithRegister"},
  {"unblevable/quick-scope"},
  {"inkarkat/argtextobj.vim"},
  {"michaeljsmith/vim-indent-object"},
  {"kana/vim-textobj-entire"},
  {"kana/vim-textobj-user"},
  {'ntpeters/vim-better-whitespace'},
  {"justinmk/vim-sneak"},
  {"easymotion/vim-easymotion"},
  {"ethanholz/nvim-lastplace"},
  {"bronson/vim-visual-star-search"},
}

-- https://github.com/ethanholz/nvim-lastplace
require'nvim-lastplace'.setup {
    lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
    lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
    lastplace_open_folds = true
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- https://www.lunarvim.org/docs/configuration/autocommands
-- https://til.hashrocket.com/posts/17c44eda91-persistent-folds-between-vim-sessions
vim.api.nvim_create_autocmd("BufWinLeave", {
      pattern =  "*", command = "mkview",
})
vim.api.nvim_create_autocmd("BufWinEnter", {
      pattern =  "*", command = "silent! loadview",
})

-- https://www.reddit.com/r/lunarvim/comments/10392z6/statusbar/
lvim.builtin.lualine.active = false
lvim.builtin.bufferline.active = false
lvim.builtin.breadcrumbs.active = false
vim.opt.laststatus = 0
vim.opt.showtabline = 0

-- https://www.lunarvim.org/configuration/03-colorschemes.html#transparent-windows
lvim.transparent_window = true

-- https://www.lunarvim.org/configuration/01-settings.html#example-options
vim.opt.cursorline = false -- don't highlight the current line
vim.opt.cmdheight = 1 -- less space in the neovim command line for displaying messages
vim.opt.number = false
vim.opt.timeoutlen = 200 -- more time to wait for a mapped sequence to complete (in milliseconds)
