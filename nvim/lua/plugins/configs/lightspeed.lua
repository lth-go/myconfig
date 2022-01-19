local present, lightspeed = pcall(require, "lightspeed")

if not present then
  return
end

lightspeed.setup({
  jump_to_unique_chars = false,
})
