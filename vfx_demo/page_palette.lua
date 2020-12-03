function pp_init(self)
  set_palette(self.palette)
end

function pp_draw(self)
  for i=0,7 do
    rectfill(
      i*4,124,
      i*4+3,127,
      i)
  end

  spr(64,64-32,64-32,8,8)
end

function add_palette_pages()
  add(pages, {
    title="grayscale",
    palette=palette_grayscale,
    init=pp_init,
    draw=pp_draw
  })
  add(pages, {
    title="fireball",
    palette=palette_blendable,
    init=pp_init,
    draw=pp_draw
  })
  add(pages, {
    title="smoke",
    palette=palette_smoky,
    init=pp_init,
    draw=pp_draw
  })
  add(pages, {
    title="cotton candy",
    palette=palette_cotton_candy,
    init=pp_init,
    draw=pp_draw
  })
  add(pages, {
    title="plasma",
    palette=palette_plasma,
    init=pp_init,
    draw=pp_draw,
    update=shift_palette_plasma
  })
end

function loop_index(index)
  return (index-1)%8 + 1
end

function shift_palette_plasma(self)
  if plasma_index == nil then
    plasma_index = 1
    plasma_timer = 10
  end
  plasma_timer -= 1
  if plasma_timer == 0 then
    plasma_timer = 10
    self.palette[loop_index(10-plasma_index)+1]=0
    self.palette[loop_index(11-plasma_index)+1]=0
    plasma_index = loop_index(plasma_index + 1)
    printh(plasma_index)
    self.palette[loop_index(10-plasma_index)+1]=12
    self.palette[loop_index(11-plasma_index)+1]=7
    set_palette(self.palette)
  end
end