local M = {}
function M.mapo(m, k, v, opts)
    vim.keymap.set(m, k, v, opts)
end

function M.map(m, k, v, silent)
    M.mapo(m, k, v, { silent = silent ~= false })
end

function M.nmap(k, v, silent)
    M.map("n", k, v, silent)
end
function M.nmapo(k, v, opts)
    M.mapo("n", k, v, opts)
end

function M.imap(k, v, silent)
    M.map("i", k, v, silent)
end
function M.imapo(k, v, opts)
    M.mapo("i", k, v, opts)
end

function M.nvmap(k, v, silent)
    M.map("n", k, v, silent)
    M.map("v", k, v, silent)
end
function M.nvmapo(k, v, opts)
    M.mapo("n", k, v, opts)
    M.mapo("v", k, v, opts)
end

return M
