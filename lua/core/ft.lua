local ft = {
  {
    ext = 'gd',
    name = 'gdscript',
  },
}

for i, mapping in pairs(ft) do
  vim.filetype.add({
    extension = {
      [mapping.ext] = mapping.name,
    },
  })
end
