function pb_init(self)
  reset_effects()

  local step_emitters = {
    {
      burst=512,
      pos=vec2(64, 64),
      colors={1,13,12}, -- blues
      radius={
        min=0,
        max=91
      },
      p_life={
        min=1000,
        max=1200
      }
    },
    {
      burst=512,
      pos=vec2(64, 64),
      colors={3,11,10}, -- greens
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
    },
    {
      burst=512,
      pos=vec2(64, 64),
      colors={8,9,10}, -- oranges
      speed={
        min=0,
        max=2
      },
      p_life={
        min=60,
        max=120
      }
    },
    {
      burst=512,
      pos=vec2(64, 64),
      colors={2,8,14}, -- reds
      speed={
        min=0,
        max=2
      },
      p_life={
        min=60,
        max=120
      },
      accel = vec2(0, 0.1)
    }
  }
  init_emitter(
    step_emitters[page_step]
  )
end