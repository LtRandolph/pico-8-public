function pm_init(self)
  init_emitter(self.e)
end

function add_model_pages()
  add(pages, {
    title="model",
    init=pm_init,
    e={
      spawn_rate=0.25,
      colors={1,2,3,4,5,6,7,8,
        9,10,11,12,13,14,15},
      speed={
        min=0,
        max=1
      },
      radius={
        min=0,
        max=91
      },
      p_life={
        min=60,
        max=120
      },
      size={
        min=4,
        max=16
      },
      draw=model_draw
    }
  })
end

model_points ={
  vec2(sin(0.25), cos(0.25)),
  vec2(sin(0.65), cos(0.65)),
  vec2(sin(0.05), cos(0.05)),
  vec2(sin(0.45), cos(0.45)),
  vec2(sin(0.85), cos(0.85)),
}
function model_draw(p)
  line()
  for model_point in all(model_points) do
    line(p.pos.x + p.size * model_point.x,
      p.pos.y + p.size * model_point.y,
      p.col
    )
  end
  line(p.pos.x + p.size * model_points[1].x,
    p.pos.y + p.size * model_points[1].y
  )
end