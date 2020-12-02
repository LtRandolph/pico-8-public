function update_particle(p)
  p.life -= 1
  if p.life <= 0 then
    del(particles, p)
    return
  end
  p.vel += p.accel
  p.pos += p.vel
end

function update_particles()
  foreach(particles,
    update_particle)
end

function draw_particle(p)
  pset(p.pos.x, p.pos.y,
    p.col)
end

function draw_particles()
  foreach(particles,
    draw_particle)
end