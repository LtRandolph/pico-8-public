function init_emitter(e)
  add(emitters, e)

  e.spawn_accum=0
  if e.spawn_rate==nil then
    e.spawn_rate=0
  end

  for i=1,(e.burst or 0) do
    spawn_particle(e)
  end
end

function spawn_particle(e)
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
  p.accel_noise = get_value(
    e.accel_noise)
  p.size = get_value(e.size)
  p.angle = get_value(e.angle)
  p.sprite = e.sprite
  p.alpha = get_value(e.alpha, 1)
  p.air_resist = get_value(
    e.air_resist)

  add(particles, p)
end

function update_emitter(e)
  e.spawn_accum+=e.spawn_rate
  while e.spawn_accum > 1 do
    e.spawn_accum -= 1
    spawn_particle(e)
  end
end

function update_emitters()
  foreach(emitters,
    update_emitter)
end