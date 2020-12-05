function pb_init(self)
  init_emitter(self.e)
end

function add_basic_pages()
  add(pages, {
    title="particles",
    center_title=true
  })
  add(pages, {
    title="our goal is to fill the screen\n"..
      "with thousands or millions of\n"..
      "rgb pixels."
  })
  add(pages, {
    title="we can draw pixels in space.\n"..
      "these are called particles.",
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
    title="we can move them around",
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
    title="stretch them out",
    init=pb_init,
    e={
      burst=64,
      colors={5,6,7},
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
      size=7
    }
  })
  add(pages, {
    title="and rotate them.",
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
      angle={
        min=0,
        max=1
      }
    }
  })
  add(pages, {
    title="acceleration makes their motion\n"..
      "more visually interesting.",
    init=pb_init,
    e={
      burst=128,
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
      accel=vec2(0, 0.1),
      size=3
    }
  })
  add(pages, {
    title="their acceleration can take\n"..
      "their position into account",
    init=pb_init,
    e={
      spawn_rate=2,
      pos=vec2(64, 64),
      colors={1,12,7},
      speed={
        min=0.5,
        max=1
      },
      p_life={
        min=60,
        max=120
      },
      accel=swirl_accel,
      size=3
    }
  })
  add(pages, {
    title="as well as the position of\n"..
      "other objects.",
    init=pb_init,
    e={
      spawn_rate=2,
      pos=vec2(64, 64),
      colors={11,12,13},
      speed={
        min=1,
        max=2
      },
      p_life={
        min=60,
        max=120
      },
      accel=mouse_accel,
      size=3
    }
  })
  add(pages, {
    title="we can even bump into those\n"..
      "other objects.",
    init=pb_init,
    e={
      burst=128,
      pos=vec2(64, 64),
      colors={11,15,10},
      speed={
        min=2,
        max=4
      },
      p_life=-1,
      p_update=collision_update,
      accel=vec2(0, 0.1),
      size=3
    }
  })
end

function swirl_accel(e, p)
  offset = p.pos - vec2(64,64)
  accel = -0.001 * offset
  accel += 0.0015 * vec2(offset.y, -offset.x)
  return accel
end

function mouse_accel(e, p)
  offset = p.pos - mouse
  accel = -0.004 * offset
  accel += 0.001 * vec2(offset.y, -offset.x)
  return accel
end

function collision_update(p)
  if p.pos.x < 0 then
    p.pos.x = -p.pos.x
    p.vel.x = -0.9 * p.vel.x
  end
  if p.pos.y < 0 then
    p.pos.y = -p.pos.y
    p.vel.y = -0.9 * p.vel.y
  end
  
  if p.pos.x > 127 then
    p.pos.x = 127-(p.pos.x-127)
    p.vel.x = -0.9 * p.vel.x
  end
  if p.pos.y > 127 then
    p.pos.y = 127-(p.pos.y-127)
    p.vel.y = -0.9 * p.vel.y
  end
end