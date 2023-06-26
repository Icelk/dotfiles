local A = vim.api
local map = require "map"
local nmapo = map.nmapo
local imapo = map.nmapo
local nmap = map.nmap
local nvmapo = map.nvmapo

A.nvim_create_autocmd("BufWritePost", {
    group = A.nvim_create_augroup("packer_user_config", {}),
    pattern = "plugins.lua",
    callback = function() vim.cmd("source <afile> | PackerCompile") end,
})
A.nvim_create_autocmd("BufRead", {
    pattern = "*.ron",
    callback = function() vim.o.filetype = "ron" end,
})
A.nvim_create_autocmd("BufNewFile", {
    pattern = "*.ron",
    callback = function() vim.o.filetype = "ron" end,
})

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'         -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp'     -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip'         -- Snippets plugin

    use 'honza/vim-snippets'

    use 'airblade/vim-gitgutter'
    use 'windwp/nvim-autopairs'
    use 'terrortylor/nvim-comment'

    use 'jose-elias-alvarez/null-ls.nvim'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'simrat39/rust-tools.nvim'
    use {
        'saecki/crates.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    }

    use { "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } }
    use { 'stevearc/dressing.nvim' }

    use 'andersevenrud/nordic.nvim'
    use "ellisonleao/gruvbox.nvim"
end)

vim.cmd.colorscheme("gruvbox")
vim.cmd("highlight Normal guibg=none")

require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "svelte", "typescript", "ron", "wgsl", "wgsl_bevy", "javascript", "css", "rust", "lua" },
    auto_install = true,
    highlight = { enable = true },
}
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

-- TELESCOPE
local telescope = require "telescope"
local telescope_actions = require "telescope.actions"
local tele_builtin = require "telescope.builtin"
-- local tele_theme = require "telescope.themes".get_ivy()
local tele_theme = nil

telescope.setup { defaults = { mappings = { i = { ["<esc>"] = telescope_actions.close } } } }

-- Telescope for nvim UI
require "dressing".setup { select = { telescope = tele_theme } }

nmap("<C-p>", function() tele_builtin.find_files(tele_theme) end)
nmap("<C-g>", function() tele_builtin.oldfiles(tele_theme) end)
nmap("<C-A-p>", function() tele_builtin.grep_string(tele_theme) end)
nmap("S", function() tele_builtin.spell_suggest(tele_theme) end)

nmap("<space>a", function() tele_builtin.diagnostics(tele_theme) end)
nmap("<space>b", function() tele_builtin.buffers(tele_theme) end)
nmap("<space>c", function() tele_builtin.git_bcommits(tele_theme) end)
nmap("<space>g", function() tele_builtin.git_stash(tele_theme) end)


require('nvim_comment').setup({ create_mappings = true, line_mapping = "<leader>cc", operator_mapping = "<leader>c" })
require('crates').setup()

-- require('nordic').colorscheme({
--     -- Underline style used for spelling
--     -- Options: 'none', 'underline', 'undercurl'
--     underline_option = 'none',
--
--     -- Italics for certain keywords such as constructors, functions,
--     -- labels and namespaces
--     italic = true,
--
--     -- Italic styled comments
--     italic_comments = false,
--
--     -- Minimal mode: different choice of colors for Tabs and StatusLine
--     minimal_mode = false,
--
--     -- Darker backgrounds for certain sidebars, popups, etc.
--     -- Options: true, false, or a table of explicit names
--     -- Supported: terminal, qf, vista_kind, packer, nvim-tree, telescope, whichkey
--     alternate_backgrounds = false,
--     custom_colors = function(c, _, _)
--         -- set floating windows to have the same BG as normal windows
--         return {
--             { { 'NormalFloat', }, c.white, c.dark_black },
--         }
--     end
-- })

local lsp_flags = {}
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspc = require 'lspconfig'
local luasnip = require 'luasnip'
require("luasnip.loaders.from_snipmate").lazy_load()

-- change border
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
-- we want to do that
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "rounded"
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    -- A.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local capabilities = client.server_capabilities

    A.nvim_create_autocmd("CursorHold,CursorHoldI,InsertLeave", {
        callback = function() A.nvim_command "silent! vim.lsp.codelens.refresh()" end,
        buffer = bufnr,
    })
    nmapo("<leader>l", vim.lsp.codelens.run)

    if capabilities.documentHighlightProvider then
        A.nvim_create_autocmd("CursorMoved", {
            callback = vim.lsp.buf.clear_references,
            buffer = bufnr,
        })
        A.nvim_create_autocmd("CursorHold,CursorHoldI", {
            callback = vim.lsp.buf.document_highlight,
            buffer = bufnr,
        })
    end

    -- Enable semantic tokens if it's available (from the fork at jdrouhard/neovim#lsp_semantic_tokens)
    if vim.lsp.semantic_tokens ~= nil and capabilities.semanticTokensProvider then
        vim.lsp.semantic_tokens.start(bufnr, client.id)
    end

    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- Remap keys for gotos
    nmapo("gd", function() tele_builtin.lsp_definitions(tele_theme) end, opts)
    nmapo("gy", function() tele_builtin.lsp_type_definitions(tele_theme) end, opts)
    nmapo("gi", function() tele_builtin.lsp_implementations(tele_theme) end, opts)
    nmapo("gr", function() tele_builtin.lsp_references(tele_theme) end, opts)
    nmapo('gD', vim.lsp.buf.declaration, opts)
    -- nmapo('<C-k>', vim.lsp.buf.signature_help, bufopts)

    nmapo('<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    nmapo('<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    nmapo('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    nvmapo('F',
        function()
            vim.lsp.buf.format { async = true,
                filter = function(c)
                    return c.name ~= "tsserver" and c.name ~= "cssls" and
                        c.name ~= "html" and c.name ~= "jsonls"
                end,

            }
        end, opts)

    -- Remap for rename current word
    nmapo("<F9>", vim.lsp.buf.rename, opts)
    -- name is a bit weird (g for goto), but other lsp-related keys are also on g, so what do we do?
    nmapo("gn", vim.lsp.buf.rename, opts)


    -- Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    nvmapo("<leader>a", vim.lsp.buf.code_action);
    nmapo("<C-a>", vim.lsp.buf.code_action);
    imapo("<C-A-Space>", vim.lsp.buf.code_action);

    nvmapo("<leader>f", function() vim.lsp.buf.code_action(nil, nil, true) end);

    nmapo("<space>o", function() tele_builtin.lsp_dynamic_workspace_symbols(tele_theme) end, opts)
    nmapo("<space>s", function() tele_builtin.lsp_document_symbols(tele_theme) end, opts)
end


-- Activate deno when both are contenders.
-- Else, activeate the respective
local tss_required = lspc.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")
local deno_required = lspc.util.root_pattern("deno.json", "deno.jsonc")
lspc.tsserver.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    root_dir = function(path)
        local tss = tss_required(path)
        local deno = deno_required(path)
        if string.len(tss or "") <= string.len(deno or "") then
            return nil
        else
            return tss
        end
    end,
}
-- lspc.rust_analyzer.setup {
--     cmd = { os.getenv("HOME") .. "/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer" },
--     on_attach = on_attach,
--     flags = lsp_flags,
--     -- Server-specific settings...
--     runnables = {
--         use_telescope = true,
--     },
--     debuggables = {
--         use_telescope = true,
--     },
--     server = {
--         settings = {
--
--             ["rust-analyzer"] = {
--                 checkOnSave = {command = "fuck"},
--                 ["checkOnSave.command"] = "fuck",
--                 ["cargo.features"] = "all",
--                 ["imports.prefix"] = "self",
--                 ["imports.granularity.group"] = "module",
--                 ["imports.granularity.enforce"] = true,
--                 ["assist.emitMustUse"] = true,
--                 ["lens.location"] = "above_whole_item",
--                 ["semanticHighlighting.operator.specialization.enable"] = true,
--                 ["semanticHighlighting.punctuation.enable"] = true,
--                 ["semanticHighlighting.punctuation.specialization.enable"] = true,
--                 ["semanticHighlighting.punctuation.separate.macro.bang"] = true,
--             }
--         }
--     },
--     capabilities = capabilities,
-- }
lspc.clangd.setup { on_attach = on_attach, flags = lsp_flags, capabilities = capabilities }
lspc.lua_ls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = A.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
vim.g.markdown_fenced_languages = {
    "ts=typescript"
}
lspc.denols.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    root_dir = function(path)
        local tss = tss_required(path)
        local deno = deno_required(path)
        if string.len(deno or "") < string.len(tss or "") then
            return nil
        else
            return deno
        end
    end,
}
lspc.cssls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
lspc.jsonls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
lspc.html.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    settings = { autoClosingTags = true }
}
lspc.tailwindcss.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
lspc.svelte.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    settings = { svelte = { plugin = { typescript = { semanticTokens = { enable = false } } } } }
}

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettier.with({
            extra_args = { "--no-semi", "--tab-width", "4" }
        }),
        -- null_ls.builtins.completion.spell,
        null_ls.builtins.diagnostics.fish,
        -- null_ls.builtins.diagnostics.php,
        null_ls.builtins.formatting.fish_indent,
        null_ls.builtins.hover.dictionary,
    },
    on_attach = on_attach,
})

local autopairs = require('nvim-autopairs')
autopairs.setup()

local rt = require("rust-tools")

rt.setup({
    runnables = {
        use_telescope = true,
    },
    debuggables = {
        use_telescope = true,
    },
    server = {
        cmd = { os.getenv("HOME") .. "/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer" },
        flags = lsp_flags,
        capabilities,
        on_attach = function(a, bufnr)
            on_attach(a, bufnr)
            -- Rust specific keybinds
            vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
            vim.keymap.set('n', '<C-x>', rt.expand_macro.expand_macro)
            vim.keymap.set('n', '<C-d>', rt.external_docs.open_external_docs)
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
        settings = {
            ["rust-analyzer"] = {
                check = { command = "clippy" },
                cargo = { features = "all" },
                imports = { prefix = "self", granularity = { group = "module", enforce = true } },
                assist = { emitMustUse = true },
                lens = { location = "above_whole_item" },
                semanticHighlighting = {
                    operator = { specialization = { enable = true } },
                    puncutation = {
                        enable = true,
                        specialization = { enable = true },
                        separate = { macro = { bang = true } }
                    }
                },
            }

        }
    },
})

rt.inlay_hints.enable()

local cmp = require 'cmp'
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)
A.nvim_create_autocmd("BufRead", {
    group = A.nvim_create_augroup("CmpSourceCargo", { clear = true }),
    pattern = "Cargo.toml",
    callback = function()
        cmp.setup.buffer({ sources = { { name = "crates" } } })
    end,
})
cmp.setup {
    preselect = cmp.PreselectMode.Item,
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete({ select = true }),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
                -- elseif luasnip.expand_or_jumpable() then
                --     luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<C-j>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable() then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<C-k>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = "crates" },
        { name = 'path' },
        { name = 'buffer' },
    },
}
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        underline = true,
        signs = true,
    }
)

A.nvim_create_autocmd("CursorHold", {
    callback = function()
        local arr = A.nvim_list_wins()
        -- if has floating window, don't open popup
        for _, win in ipairs(arr) do
            if A.nvim_win_get_config(win).relative ~= '' then
                return
            end
        end
        vim.diagnostic.open_float({ focusable = false })
    end,
})
-- A.nvim_create_autocmd("CursorHoldI", {
--     callback = function()
--         local arr = A.nvim_list_wins()
--         -- if has floating window, don't open popup
--         for i, win in ipairs(arr) do
--             if A.nvim_win_get_config(win).relative ~= '' then
--                 return
--             end
--         end
--
--         vim.lsp.buf.signature_help()
--     end,
-- })
