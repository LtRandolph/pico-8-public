function _init()
  printh("_init")
  init_pages()

  -- persist palette changes
  -- into editor
  poke(0x5f2e, 1)

  -- enable mouse
  poke(0x5f2d, 1)
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
  
  mouse_x = stat(32)
  mouse_y = stat(33)
  if mouse_x > 1 and
    mouse_x < 127 and
    mouse_y > 1 and
    mouse_y < 127 then
    line(mouse_x-2, mouse_y,
      mouse_x+2, mouse_y,
      palette.white)
    line(mouse_x, mouse_y-2,
      mouse_x, mouse_y+2,
      palette.white)
    pset(mouse_x, mouse_y, 0)
  end
end