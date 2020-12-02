function init_emitter(e)
  add(emitters, e)

  for i=1,(e.burst or 0) do
    pos = e.pos
    angle = rnd(1)
    dir = vec2(
      cos(angle),
      sin(angle)
    )
    if e.radius then
      r = get_value(e.radius)
      pos += r * dir
    end

    speed = get_value(e.speed)
    vel = speed * dir
    col = rnd(e.colors)
    life = flr(get_value(e.p_life))

    create_particle(pos,
      vel,
      life,
      col
    )
  end
end

function update_emitter(e)

end

function update_emitters()
  foreach(emitters,
    update_emitter)
end