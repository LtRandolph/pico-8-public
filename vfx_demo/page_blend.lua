function pblend_init(self)
  init_emitter(self.e)
  activate_blend(self.blend)
end

function add_blend_pages()
  add(pages, {
    title="opaque",
    init=pblend_init,
    blend=blending_alpha,
    e={
      spawn_rate=0.1,
      colors={0,1,2,3,4,5,6,7,8},
      pos=vec2(64,105),
      radius={
        min=0,
        max=20
      },
      speed={
        min=0,
        max=0.05
      },
      p_life={
        min=120,
        max=140
      },
      size={
        min=12,
        max=20
      },
      accel=vec2(0, -0.005),
      alpha=1
    }
  })
  add(pages, {
    title="alpha blend",
    init=pblend_init,
    blend=blending_alpha,
    e={
      spawn_rate=0.1,
      colors={0,1,2,3,4,5,6,7,8},
      pos=vec2(64,105),
      radius={
        min=0,
        max=20
      },
      speed={
        min=0,
        max=0.05
      },
      p_life={
        min=120,
        max=140
      },
      size={
        min=12,
        max=20
      },
      accel=vec2(0, -0.005),
      alpha=0.5
    }
  })
  add(pages, {
    title="additive",
    init=pblend_init,
    blend=blending_additive,
    e={
      spawn_rate=0.1,
      colors={0,1,2,3,4,5,6,7,8},
      pos=vec2(64,105),
      radius={
        min=0,
        max=20
      },
      speed={
        min=0,
        max=0.05
      },
      p_life={
        min=120,
        max=140
      },
      size={
        min=12,
        max=20
      },
      accel=vec2(0, -0.005),
      alpha=0.5
    }
  })
end