f, e, s, g, m, sil = vim.fn, vim.cmd, vim.opt, vim.g, vim.keymap.set, { silent = true }

packer_path = f.stdpath 'data'..'/site/pack/packer/start/packer.nvim'
if f.empty(f.glob(packer_path)) == 1 then
	f.system{'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer_path}
end
require 'packer'.startup{{
	'wbthomason/packer.nvim',
	'kyazdani42/nvim-tree.lua',
	'eddyekofo94/gruvbox-flat.nvim',
	'junegunn/fzf', 'junegunn/fzf.vim',
	'windwp/nvim-autopairs',
	'numToStr/Comment.nvim',
}}

s.cursorline, s.wrap, s.scrolloff, s.virtualedit = true, false, 10, 'all'
s.undofile, s.swapfile                           = true, false
s.splitright, s.splitbelow, s.equalalways        = true, true, false
s.number, s.relativenumber                       = true, true
s.ignorecase, s.smartcase                        = true, true
s.tabstop, s.shiftwidth                          = 4, 4
s.termguicolors                                  = true
s.clipboard                                      :append{'unnamedplus'}
g.mapleader                                      = ' '
g.gruvbox_flat_style                             = 'hard'

require 'nvim-tree'.setup{view = {width = '25%', relativenumber = true}, renderer = {icons = {show = {file = false, folder = false, folder_arrow = false, git = false}}}}
require 'nvim-autopairs'.setup{}
require 'Comment'.setup{}

m('n', 'U',         '<c-r>',                  {})
m('n', '<c-h>',     '<c-w>h',                 {})
m('n', '<c-j>',     '<c-w>j',                 {})
m('n', '<c-k>',     '<c-w>k',                 {})
m('n', '<c-l>',     '<c-w>l',                 {})
m('n', '?',         ':let @/=""<cr>',        sil)
m('n', '+',         ':vert res +15<cr>',     sil)
m('n', '-',         ':vert res -15<cr>',     sil)
m('n', '<leader>p', ':PackerSync<cr>',       sil)
m('n', '<leader>t', ':NvimTreeToggle<cr>',   sil)
m('n', '<leader>l', ':NvimTreeFindFile<cr>', sil)
m('n', '<leader>s', function()
	f['fzf#vim#grep']('rg -n -. -S '..f.shellescape(f.expand('<q-args>')),
	                       0, {['options'] = '-e'}, 0)
end)
for i = 1, 9 do m('n', 'g'..i, i..'gt', {}) end

e('colorscheme gruvbox-flat')
