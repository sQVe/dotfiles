local augroups = {}
local augroup_keys = {
  'SetMdxFiletype',
}

for _, augroup_key in ipairs(augroup_keys) do
  table.insert(augroups, vim.api.nvim_create_augroup(augroup_key, {}))
end

-- Set .mdx filetype.
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = augroups.SetMdxFiletype,
  pattern = '*.mdx',
  command = 'set filetype=markdown',
})
