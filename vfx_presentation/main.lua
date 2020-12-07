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
  
  mouse = vec2(stat(32), stat(33))
  if mouse.x > 1 and
    mouse.x < 127 and
    mouse.y > 1 and
    mouse.y < 127 then
    line(mouse.x-2, mouse.y,
      mouse.x+2, mouse.y,
      palette.white)
    line(mouse.x, mouse.y-2,
      mouse.x, mouse.y+2,
      palette.white)
    pset(mouse.x, mouse.y, 0)
  end
end