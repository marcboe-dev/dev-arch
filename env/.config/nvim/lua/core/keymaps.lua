-- Keymaps for better default experience

-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- For conciseness
local opts = { noremap = true, silent = true }

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Allow moving the cursor through wrapped lines with j, k
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- clear highlights
vim.keymap.set('n', '<Esc>', ':noh<CR>', opts)

-- save file
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)

-- save file without auto-formatting
vim.keymap.set('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts)

-- quit file
vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', opts)

vim.keymap.set({ 'n', 'v' }, '<leader>D', '"_d', opts) -- changed this for debugging config
vim.keymap.set('n', '<leader>dd', '"_dd', opts) -- delete line
-- vim.keymap.set('n', '<leader>D', '"_D', opts) -- delete to end of line

-- Paste without losing register
vim.keymap.set('x', '<leader>p', [["_dP]])

-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Resize with arrows
vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)

-- Increment/decrement numbers
vim.keymap.set('n', '<leader>+', '<C-a>', opts) -- increment
vim.keymap.set('n', '<leader>-', '<C-x>', opts) -- decrement

-- Window management
vim.keymap.set('n', '<leader>v', '<C-w>v', opts) -- split window vertically
vim.keymap.set('n', '<leader>h', '<C-w>s', opts) -- split window horizontally
vim.keymap.set('n', '<leader>se', '<C-w>=', opts) -- make split windows equal width & height
vim.keymap.set('n', '<leader>xs', ':close<CR>', opts) -- close current split window

-- Navigate between splits
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)

-- Tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts) -- open new tab
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts) --  go to next tab
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts) --  go to previous tab

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Press jk fast to exit insert mode
vim.keymap.set('i', 'jk', '<ESC>', opts)
vim.keymap.set('i', 'kj', '<ESC>', opts)

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Move text up and down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==') -- move line up(n)
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==') -- move line down(n)
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv") -- move line up(v)
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv") -- move line down(v)

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', opts)

-- Start search/replace for word under cursor; Pre-fills the search/replace command with the current word.
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Explicitly yank to system clipboard (highlighted and entire row)
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- Save and load session
vim.keymap.set('n', '<leader>ss', ':mksession! .session.vim<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>sl', ':source .session.vim<CR>', { noremap = true, silent = false })

-- Make current file executable
vim.keymap.set('n', '<leader>x', ':!chmod +x %<CR>', { noremap = true, silent = true, desc = 'Make file executable' })

-- ==========================================
-- DAP (Debug Adapter Protocol) Keymaps
-- ==========================================
-- All debugging keymaps are defined in: dap.lua
--
-- Function Keys:
--   F5  - Run/Continue
--   F6  - Step Over
--   F7  - Step Into
--   F8  - Step Out
--   F10 - Restart
--
-- Leader + d + action:
--   <leader>dr  - Toggle REPL
--   <leader>dt  - Terminate
--   <leader>du  - Toggle DAP UI
--   <leader>da  - Run with Args
--   <leader>db  - Toggle Breakpoint
--   <leader>dB  - Breakpoint Condition
--   <leader>dC  - Run to Cursor
--   <leader>de  - Evaluate
--   <leader>dg  - Go to Line (No Execute)
--   <leader>dj  - Down
--   <leader>dk  - Up
--   <leader>dl  - Run Last
--   <leader>dP  - Pause
--   <leader>ds  - Session
--   <leader>dw  - Widgets
-- ==========================================

-- Tmux-sessionizer keymaps
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')
vim.keymap.set('n', '<M-h>', '<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>')
vim.keymap.set('n', '<M-t>', '<cmd>silent !tmux neww tmux-sessionizer -s 1<CR>')
vim.keymap.set('n', '<M-n>', '<cmd>silent !tmux neww tmux-sessionizer -s 2<CR>')
vim.keymap.set('n', '<M-s>', '<cmd>silent !tmux neww tmux-sessionizer -s 3<CR>')
