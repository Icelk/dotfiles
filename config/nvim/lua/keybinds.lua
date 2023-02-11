local map = require "map"
local nmap = map.nmap
local imap = map.imap
local vmap = map.vmap

nmap("'", ":", false)
vmap("'", ":", false)


-- lspconfig
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
nmap('<space>e', vim.diagnostic.open_float)
nmap('[d', vim.diagnostic.goto_prev)
nmap(']d', vim.diagnostic.goto_next)
nmap('<space>q', vim.diagnostic.setloclist)

nmap("<C-h>", "<C-w>h")
nmap("<C-j>", "<C-w>j")
nmap("<C-k>", "<C-w>k")
nmap("<C-l>", "<C-w>l")

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

-- Go to next/prev git changes
nmap("[f", "<CMD>GitGutterPrevHunk<CR>")
nmap("]f", "<CMD>GitGutterNextHunk<CR>")

-- Stage/revert hunk
-- I know this is ugly (g is usually the 'go to', but now it's Git!)
nmap("gs", "<CMD>GitGutterStageHunk<CR>")
nmap("gu", "<CMD>GitGutterUndoHunk<CR>")

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
