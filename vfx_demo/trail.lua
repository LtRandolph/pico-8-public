function create_trail(def, pos)
  t = {
    colors=def.colors,
    prof_dist=def.prof_dist,
    prof_life=def.prof_life,
    prof={},
    head=pos
  }
  add_profile(t, pos)
  add(trails, t)
  return t
end

function add_profile(t, pos)
  add(t.prof, {
    pos=pos,
    life=t.prof_life,
    color=rnd(t.colors)
  })
end

function update_trail(t)
  offset = t.head -
    t.prof[#t.prof].pos
  dist = #offset

  while dist > t.prof_dist do
    offset_part = (t.prof_dist /
      dist) * offset
    new_pos = t.prof[#t.prof].pos +
      offset_part

    add_profile(t, new_pos)
    
    offset = t.head -
      t.prof[#t.prof].pos
    dist = #offset
  end

  for prof in all(t.prof) do
    prof.life -= 1
    if prof.life <= 0 and
      #t.prof > 1 then
      del(t.prof, prof)
    end
  end
end

function update_trails()
  foreach(trails,
    update_trail)
end

function draw_trail(t)
  line()
  for prof in all(t.prof) do
    line(prof.pos.x, prof.pos.y)
    color(get_value(t, prof, prof.color))
  end
  line(t.head.x, t.head.y)
end

function draw_trails()
  foreach(trails,
    draw_trail)
end