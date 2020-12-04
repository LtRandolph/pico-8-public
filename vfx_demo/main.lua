function _init()
  printh("_init")
  init_pages()

  -- persist palette changes
  -- into editor
  poke(0x5f2e, 1)
end

function _update60()
  update_pages()

  if not paused then
    update_emitters()
    update_particles()
    update_trails()
  end
end

function _draw()
  cls()
  draw_particles()
  draw_trails()
  -- draw page last so title
  -- will overwrite particles
  draw_pages()
end