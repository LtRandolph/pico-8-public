function init_emitter(e)
  add(emitters, e)

  if (e.pos==nil) e.pos = vec2(64,64)
  e.spawn_accum=0
  e.alive_time=0
  if e.spawn_rate==nil then
    e.spawn_rate=0
  end

  for i=1,(e.burst or 0) do
    spawn_particle(e)
  end
end

function spawn_particle(e)
  p = {}

  p.emitter = e
  p.alive_time = 0
  p.pos = e.pos
  angle = rnd(1)
  p.dir = vec2(
    cos(angle),
    sin(angle)
  )
  if e.radius then
    r = get_value(e, p, e.radius)
    p.pos += r * p.dir
  end

  speed = get_value(e, p, e.speed)
  p.vel = speed * p.dir
  p.col = rnd(e.colors)
  p.life = flr(get_value(e, p,
    e.p_life))
  p.accel = e.accel
  p.size = get_value(e, p,
    e.size)
  p.angle = get_value(e, p,
    e.angle)
  p.sprite = e.sprite
  p.alpha = get_value(e, p,
    e.alpha, 1)
  p.air_resist = get_value(e, p,
    e.air_resist)

  add(particles, p)
end

function update_emitter(e)
  e.alive_time+=1
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