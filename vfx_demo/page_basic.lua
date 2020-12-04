function pb_init(self)
  init_emitter(self.e)
end

function add_basic_pages()
  add(pages, {
    title="blank",
    e={}
  })
  add(pages, {
    title="pixels",
    init=pb_init,
    e={
      burst=512,
      colors={1,13,12},
      radius={
        min=0,
        max=91
      },
      p_life=-1
    }
  })
  add(pages, {
    title="motion",
    init=pb_init,
    e={
      burst=512,
      colors={3,11,10},
      radius={
        min=0,
        max=91
      },
      speed={
        min=0.1,
        max=0.2
      },
      p_life={
        min=60,
        max=120
      }
    }
  })
  add(pages, {
    title="size",
    init=pb_init,
    e={
      burst=64,
      colors={8,9,10},
      radius={
        min=0,
        max=15
      },
      speed={
        min=0,
        max=0.5
      },
      p_life={
        min=200,
        max=200
      },
      size=7,
      alpha=1
    }
  })
  add(pages, {
    title="texture",
    init=pb_init,
    e={
      burst=12,
      sprite=1,
      speed={
        min=0,
        max=2
      },
      p_life={
        min=60,
        max=120
      },
      size={
        min=vec2(8, 8),
        max=vec2(24, 24)
      }
    }
  })
  add(pages, {
    title="acceleration",
    init=pb_init,
    e={
      burst=512,
      pos=vec2(64, 16),
      colors={2,8,14},
      speed={
        min=0,
        max=2
      },
      p_life={
        min=60,
        max=120
      },
      accel=vec2(0, 0.1)
    }
  })
  add(pages, {
    title="position-based",
    init=pb_init,
    e={
      spawn_rate=3,
      pos=vec2(64, 64),
      colors={2,8,14},
      speed={
        min=1,
        max=2
      },
      p_life={
        min=60,
        max=120
      },
      accel=swirl_accel
    }
  })
end

function swirl_accel(e, p)
  offset = p.pos - vec2(64,64)
  accel = -0.005 * offset
  accel += 0.002 * vec2(offset.y, -offset.x)
  return accel
end