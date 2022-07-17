local present, leap = pcall(require, "leap")

if not present then
  return
end

leap.set_default_keymaps()
leap.setup({
  highlight_unlabeled = true,
})
