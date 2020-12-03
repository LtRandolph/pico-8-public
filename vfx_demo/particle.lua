function update_particle(p)
  if p.life > 0 then
    p.life -= 1
    if p.life == 0 then
      del(particles, p)
      return
    end
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

    if p.sprite then
      blending.draw_sprite(
        p.sprite, p_min, p_max,
        p.alpha)
    elseif p.angle != 0 then
      blending.rotated_rect(
        p.col, p_min, p_max,
        p.angle, p.alpha)
    else
      blending.aligned_rect(
        p.col, p_min, p_max,
        p.alpha)
    end
  end
end

function draw_particles()
  foreach(particles,
    draw_particle)
end