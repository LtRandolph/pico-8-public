function pblend_init(self)
  init_emitter(self.e)
  activate_blend(self.blend)
end

function add_blend_pages()
  add(pages, {
    title="blending",
    center_title=true
  })
  add(pages, {
    title="as each particle is drawn, it's\n"..
      "broken into fragments for each\n"..
      "pixel it may affect.",
    draw=draw_fragments
  })
  add(pages, {
    title="if the particle is opaque, each\n"..
      "fragment overwrites the pixel.",
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
    title="but we can also do a linear\n"..
      "interpolation, called an alpha\n"..
      "blend.",
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
    title="or we can add the rgb together,\n"..
      "making the pixel brighter.",
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

function draw_fragments()
  s_min = vec2(
    8 * (20 % 16),
    8 * (20 \ 16)
  )

  sspr(32, 8, 16, 16,
    40, 70, 48, 48)
end