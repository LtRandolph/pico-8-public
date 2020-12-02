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
      r = rnd_float(
        e.radius.min,
        e.radius.max)
      pos += r * dir
    end

    speed = rnd_float(
      e.speed.min,
      e.speed.max
    )
    vel = speed * dir
    col = rnd(e.colors)
    life = rnd_int(
      e.p_life.min,
      e.p_life.max
    )

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