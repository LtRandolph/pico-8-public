function _init()
  printh("_init")
  init_pages()
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