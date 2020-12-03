function _init()
  printh("_init")
  init_pages()

  -- persist palette changes
  -- into editor
  poke(0x5f2e, 1)
end

function _update60()
  update_pages()
  update_emitters()
  update_particles()
end

function _draw()
  cls()
  draw_particles()
  -- draw page last so title
  -- will overwrite particles
  draw_pages()
end