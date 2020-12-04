function pe_init(self)
  init_emitter(self.e)
end

function add_emitter_pages()
  add(pages, {
    title="burst",
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
    title="spawn rate",
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
      },
      accel = vec2(0, -0.1),
    }
  })
end