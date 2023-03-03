vim.g.mapleader = " "

local keymap = vim.keymap

-- Better up/down for wrapped lines
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Move Lines
keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Buffers
keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" }) -- ":e #" is equivalent to "<C-^>" with a slightly difference, type ":h :e#" to see more

-- Clear search with <esc>
keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
keymap.set(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

keymap.set({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
keymap.set("i", ",", ",<c-g>u")
keymap.set("i", ".", ".<c-g>u")
keymap.set("i", ";", ";<c-g>u")

-- save file
keymap.set({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- lazy
keymap.set("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- new file
keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

keymap.set("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
keymap.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- if not Util.has("trouble.nvim") then
  -- keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
  -- keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
-- end

-- stylua: ignore start

-- toggle options
local M = {}
function M.toggle(option)
    vim.opt_local[option] = not vim.opt_local[option]:get()
end
-- keymap.set("n", "<leader>uf", require("lazyvim.plugins.lsp.format").toggle, { desc = "Toggle format on Save" })
-- keymap.set("n", "<leader>us", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
keymap.set("n", "<leader>uw", function() M.toggle("wrap") end, { desc = "Toggle Word Wrap" })
keymap.set("n", "<leader>ul", function() M.toggle("relativenumber") M.toggle("number") end, { desc = "Toggle Line Numbers" })
-- keymap.set("n", "<leader>ud", Util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
-- local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
-- keymap.set("n", "<leader>uc", function() Util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })

-- lazygit
-- keymap.set("n", "<leader>gg", function() Util.float_term({ "lazygit" }, { cwd = Util.get_root() }) end, { desc = "Lazygit (root dir)" })
-- keymap.set("n", "<leader>gG", function() Util.float_term({ "lazygit" }) end, { desc = "Lazygit (cwd)" })

-- quit
keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  keymap.set("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end

-- floating terminal
-- keymap.set("n", "<leader>ft", function() Util.float_term(nil, { cwd = Util.get_root() }) end, { desc = "Terminal (root dir)" })
-- keymap.set("n", "<leader>fT", function() Util.float_term() end, { desc = "Terminal (cwd)" })
-- keymap.set("t", "<esc><esc>", "<c-\\><c-n>", {desc = "Enter Normal Mode"})

-- windows
keymap.set("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
keymap.set("n", "<leader>w-", "<C-W>s", { desc = "Split window below" })
keymap.set("n", "<leader>w|", "<C-W>v", { desc = "Split window right" })
keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split window right" })

-- tabs
keymap.set("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
keymap.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
keymap.set("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
