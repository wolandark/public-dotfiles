require("mason").setup({
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗"
			}
		}
	})
require("mason-lspconfig").setup({
		ensure_installed = { "lua_ls", "phpactor", "emmet_ls", "emmet_language_server" }
	})

require("lspconfig").lua_ls.setup {}
require("lspconfig").emmet_ls.setup {}
require("lspconfig").emmet_language_server.setup {}

require'lspconfig'.phpactor.setup{
	-- on_attach = on_attach,
	init_options = {
		["language_server_phpstan.enabled"] = false,
		["language_server_psalm.enabled"] = false,
	}
}

vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})

-- cmp --
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
local cmp = require('cmp')
local luasnip = require("luasnip")

--{{{
--------------------------------------------------
-- Pretty much default, works but is not using TAB
-- cmp.setup({
--   snippet = {
--     expand = function(args)
--       require('luasnip').lsp_expand(args.body)
--     end,
--   },
--   window = {
--     completion = cmp.config.window.bordered(),
--     documentation = cmp.config.window.bordered(),
--   },
--   mapping = cmp.mapping.preset.insert({
--     ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<C-e>'] = cmp.mapping.abort(),
--     ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--   }),
--   sources = cmp.config.sources({
--     { name = 'nvim_lsp' },
--     { name = 'luasnip' }, -- For luasnip users.
-- 	{ name = 'path' },
--     -- { name = 'vsnip' }, -- For vsnip users.
--     -- { name = 'ultisnips' }, -- For ultisnips users.
--     -- { name = 'snippy' }, -- For snippy users.
--   }, {
--     { name = 'buffer' },
--   })
-- })

-- end cmp --
--

--------------------------------------------
-- From Examples (not working with snippets)
-- cmp.setup({
-- 		snippet = {
-- 			expand = function(args)
-- 				-- require('luasnip').lsp_expand(args.body)
-- 				require("luasnip.loaders.from_vscode").lazy_load()
-- 			end,
-- 		},
-- 		mapping = {

-- 			-- ... Your other mappings ...
-- 			['<CR>'] = cmp.mapping(function(fallback)
-- 				if cmp.visible() then
-- 					if luasnip.expandable() then
-- 						luasnip.expand()
-- 					else
-- 						cmp.confirm({
-- 								select = true,
-- 							})
-- 					end
-- 				else
-- 					fallback()
-- 				end
-- 			end),

-- 			["<Tab>"] = cmp.mapping(function(fallback)
-- 				if cmp.visible() then
-- 					cmp.select_next_item()
-- 				elseif luasnip.locally_jumpable(1) then
-- 					luasnip.jump(1)
-- 				else
-- 					fallback()
-- 				end
-- 			end, { "i", "s" }),

-- 		["<S-Tab>"] = cmp.mapping(function(fallback)
-- 			if cmp.visible() then
-- 				cmp.select_prev_item()
-- 			elseif luasnip.locally_jumpable(-1) then
-- 				luasnip.jump(-1)
-- 			else
-- 				fallback()
-- 			end
-- 		end, { "i", "s" }),
-- },

--   sources = cmp.config.sources({
--     { name = 'nvim_lsp' },
--     { name = 'luasnip' }, -- For luasnip users.
-- 		{ name = 'path' },
--     }, {
--     { name = 'buffer' },
--   })
-- })
--}}}

-----------------------
-- thank god for gpt --
-- cmp ----------------
-- --------------------
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
local cmp = require('cmp')
local luasnip = require("luasnip")

-- Load the VSCode snippets
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
    { name = 'path' },
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- end cmp --
-- vim: foldmethod=marker
