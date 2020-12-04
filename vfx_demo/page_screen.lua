function ps_init(self)
  theta = 0
  choose_screen_effect_pattern()
end

function ps_update(self)
  theta += 0.005
  if theta > 1 then
    theta -= 1
    choose_screen_effect_pattern()
  end
end

function choose_screen_effect_pattern()
  screen_pattern = {
    1,2,4,8,16,32,64,128,256,512,
    1024,2048,4096,8192,16384,32768
  }
  for i=1,16 do
    swap_index = rnd_int(i,16)
    
    swap=screen_pattern[i]
    screen_pattern[i] =
      screen_pattern[swap_index]
    screen_pattern[swap_index] = 
      swap
  end
end

function ps_draw(self)
  map(0,0,0,0,16,16)
  
  alpha = clamp((0.5 + cos(theta)), 0, 1)
  pattern = 0b0.1
  for i=1,flr(lerp(0,16,alpha)) do
    pattern += screen_pattern[i]
  end

  fillp(pattern)
  rectfill(0,0,127,127,0)
  fillp()
end

function add_screen_pages()
  add(pages, {
    title="screen FX",
    init=ps_init,
    update=ps_update,
    draw=ps_draw,
  })
end