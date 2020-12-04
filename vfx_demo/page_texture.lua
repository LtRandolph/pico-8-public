function ptex_init(self)
  init_emitter(self.e)
end

function add_texture_pages()
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
end