function peff_init(self)
  for e in all(self.e) do
    init_emitter(e)
  end
end

function add_effect_pages()
  add(pages, {
    title="effects",
    center_title=true
  })
  add(pages, {
    title="we can group multiple emitters\n"..
      "into an effect.",
    init=peff_init,
    e={
      { -- fire
        spawn_rate=2,
        colors={8,9,10},
        pos=vec2(64,105),
        radius={
          min=0,
          max=15
        },
        speed={
          min=0,
          max=0.5
        },
        p_life={
          min=20,
          max=30
        },
        size={
          min=5,
          max=9
        },
        accel=vec2(0, -0.05)
      },
      { -- smoke
        spawn_rate=0.5,
        colors={5},
        pos=vec2(64,64),
        radius={
          min=0,
          max=15
        },
        speed={
          min=0,
          max=0.75
        },
        p_life={
          min=240,
          max=320
        },
        size={
          min=5,
          max=12
        },
        accel=vec2(0, -0.05)
      },
    }
  })
  add(pages, {
    title="often in games, effects will\n"..
      "also have sounds, and even spawn\n"..
      "new game objects."
  })
end