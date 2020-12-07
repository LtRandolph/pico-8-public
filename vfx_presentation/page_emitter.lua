function pe_init(self)
  init_emitter(self.e)
end

function add_emitter_pages()
  add(pages, {
    title="emitters",
    center_title=true
  })
  add(pages, {
    title="particles are spawned by\n"..
      "emitters or particle systems.\n"..
      "maybe in a burst",
    init=pe_init,
    e={
      burst=512,
      colors={8,9,10},
      speed={
        min=0,
        max=1
      },
      p_life={
        min=60,
        max=120
      }
    }
  })
  add(pages, {
    title="or maybe over time.",
    init=pe_init,
    e={
      spawn_rate=2.8,
      colors={8,9,10},
      speed={
        min=0.5,
        max=2
      },
      p_life={
        min=60,
        max=120
      }
    }
  })
  add(pages, {
    title="the emitter controls each new\n"..
      "particle's position",
    init=pe_init,
    e={
      spawn_rate=2.8,
      colors={8,9,10},
      p_life={
        min=60,
        max=120
      },
      speed={
        min=0.03,
        max=0.1
      },
      custom_spawn=spawn_pos
    }
  })
  add(pages, {
    title="and velocity.",
    init=pe_init,
    e={
      spawn_rate=2.8,
      colors={8,9,10},
      p_life={
        min=60,
        max=120
      },
      speed={
        min=1,
        max=3
      },
      custom_spawn=spawn_angle,
      accel = vec2(0, 0.1),
      angle = 0
    }
  })
end

function spawn_angle(e, p)
  e.angle += 0.001
  e.angle = frac(e.angle)
  p.pos = e.pos
  p.dir = vec2(
    cos(e.angle),
    sin(e.angle)
  )
  speed = get_value(e, p, e.speed)
  p.vel = speed * p.dir
end

a_lines = {
  {vec2(0, 127),vec2(64, 0)},
  {vec2(127, 127),vec2(64, 0)},
  {vec2(32, 64),vec2(96, 64)}
}
function spawn_pos(e, p)
  a_line = rnd(a_lines)
  p.pos = lerp(a_line[1], a_line[2],
    rnd(1))

  angle = rnd(1)
  p.dir = vec2(
    cos(angle),
    sin(angle)
  )
  speed = get_value(e, p, e.speed)
  p.vel = speed * p.dir
end