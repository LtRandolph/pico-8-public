function pt_init(self)
  self.theta = 0
  self.omega = 0
  self.t = create_trail(
    self.def,
    pt_get_head_pos(self)
  )
end

function pt_get_head_pos(self)
  radius = 32 + 8 * sin(self.omega)
  return vec2(64, 64) +
    radius * vec2(
      cos(self.theta),
      sin(self.theta)
    )
end

function pt_update(self)
  self.theta += 0.001
  self.omega += 0.0093
  self.t.head =
    pt_get_head_pos(self)
    if (btnp(0)) self.t.prof_dist /= 2
    if (btnp(1)) self.t.prof_dist *= 2
end

function add_trail_pages()
  add(pages, {
    title="trail",
    init=pt_init,
    update=pt_update,
    def={
      prof_life=300,
      prof_dist=5,
      colors={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}
    }
  })
end