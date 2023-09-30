local map = require "map"
local nmap = map.nmap
local imap = map.imap
local vmap = map.vmap
local gmap = map.map

nmap("'", ":", false)
vmap("'", ":", false)

nmap("<C-f>", "<C-d>")
nmap("<C-b>", "<C-u>")
nmap("<C-n>", "5<C-e>")
nmap("<C-m>", "5<C-y>")

-- lspconfig
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
nmap("<space>e", vim.diagnostic.open_float)
nmap("[d", vim.diagnostic.goto_prev)
nmap("]d", vim.diagnostic.goto_next)
nmap("<space>q", vim.diagnostic.setloclist)

gmap({"i", "n"}, "<C-h>", "<esc><C-w>h")
gmap({"i", "n"}, "<C-j>", "<esc><C-w>j")
gmap({"i", "n"}, "<C-k>", "<esc><C-w>k")
gmap({"i", "n"}, "<C-l>", "<esc><C-w>l")
imap("<C-w>", "<esc><C-w>")

-- Go to start/end of line in insert mode.
imap("<S-Left>", "<C-o>0")
imap("<S-Right>", "<C-o>$")
imap("<C-a>", "<C-o>0")
imap("<C-e>", "<C-o>$")

imap("<S-enter>", "<CR><esc>kA")

nmap("j", "gj")
nmap("k", "gk")

-- Toggle ignorecase
nmap("<F8>", function() vim.o.ignorecase = not vim.o.ignorecase end)

-- Close current window
nmap("<C-q>", function() vim.api.nvim_win_close(0, false) end)

-- Go to next/prev git changes (signify gives us [c, ]c, [C, ]C)

-- Use `[g` and `]g` to navigate diagnostics
nmap("[g", vim.diagnostic.goto_prev)
nmap("]g", vim.diagnostic.goto_next)
nmap("<space>k", vim.diagnostic.goto_prev)
nmap("<space>j", vim.diagnostic.goto_next)
imap("<C-,>", vim.lsp.buf.signature_help)

local function show_documentation()
    local filetype = vim.bo.filetype
    if vim.tbl_contains({ 'vim','help' }, filetype) then
        vim.cmd('h '..vim.fn.expand('<cword>'))
    elseif vim.tbl_contains({ 'man' }, filetype) then
        vim.cmd('Man '..vim.fn.expand('<cword>'))
    elseif vim.fn.expand('%:t') == 'Cargo.toml' and require('crates').popup_available() then
        require('crates').show_popup()
    else
        vim.lsp.buf.hover()
    end
end

nmap("K", show_documentation)
map.map("t", "<Esc>", "<C-\\><C-n>")
