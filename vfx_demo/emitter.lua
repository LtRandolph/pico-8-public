function init_emitter(e)
  add(emitters, e)

  for i=1,(e.burst or 0) do
    p = {}

    p.pos = e.pos
    angle = rnd(1)
    dir = vec2(
      cos(angle),
      sin(angle)
    )
    if e.radius then
      r = get_value(e.radius)
      p.pos += r * dir
    end

    speed = get_value(e.speed)
    p.vel = speed * dir
    p.col = rnd(e.colors)
    p.life = flr(get_value(e.p_life))
    p.accel = get_value(e.accel,
      vec2(0, 0))

    add(particles, p)
  end
end

function update_emitter(e)

end

function update_emitters()
  foreach(emitters,
    update_emitter)
end