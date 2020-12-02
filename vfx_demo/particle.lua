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
  if p.size == 0 then
    pset(p.pos.x, p.pos.y,
      p.col)
  else
    if type(p.size) == "number" then
      half_size = 0.5 *
        vec2(p.size, p.size)
    else
      half_size = 0.5 * p.size
    end
    p_min = p.pos - half_size
    p_max = p.pos + half_size
    rectfill(p_min.x, p_min.y,
      p_max.x, p_max.y, p.col)
  end
end

function draw_particles()
  foreach(particles,
    draw_particle)
end