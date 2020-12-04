function pc_init(self)
  init_emitter(self.e)
end

function add_curve_pages()
  add(pages, {
    title="system time",
    init=pb_init,
    e={
      burst=512,
      pos=vec2(64, 64),
      colors={1,13,12},
      radius={
        min=0,
        max=91
      },
      p_life=-1,
      air_resist=0.3,
      accel=oscillating_accel_e
    }
  })
  add(pages, {
    title="particle time",
    init=pb_init,
    e={
      spawn_rate=1,
      pos=vec2(64, 64),
      colors={1,13,12},
      radius={
        min=0,
        max=91
      },
      p_life=120,
      air_resist=0.3,
      accel=oscillating_accel_p
    }
  })
end

function oscillating_accel_p(e, p)
  return oscillating_accel(p)
end

function oscillating_accel_e(e, p)
  return oscillating_accel(e)
end

function oscillating_accel(v)
  magnitude = 0.3 * (1 +
    sin(v.alive_time / 90))
  angle = rnd(1)
  return magnitude * vec2(
    cos(angle),
    sin(angle)
  )
end