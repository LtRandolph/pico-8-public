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
  return vec2(64, 74) +
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
    
  if (btnp(0)) self.t.prof_dist *= 2
  if (btnp(1)) self.t.prof_dist /= 2
end

function pt_draw(self)
  print("profiles: "..
    #self.t.prof ..
    "    (l/r to change)",
    1, 120, palette.white
  )
end

function add_trail_pages()
  add(pages, {
    title="trails",
    center_title=true
  })
  add(pages, {
    title="in addition to particles, trails\n"..
      "are a common visual effect. as\n"..
      "an object moves, we place\n"..
      "profiles.",
    init=pt_init,
    update=pt_update,
    draw=pt_draw,
    def={
      prof_life=300,
      prof_dist=5,
      colors={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}
    }
  })
  add(pages, {
    title="profiles can have properties\n"..
      "and curves, just like particles.",
    init=pt_init,
    update=pt_update,
    draw=pt_draw,
    def={
      prof_life=300,
      prof_dist=5,
      colors={get_trail_color}
    }
  })
end

function get_trail_color(t, p)
  return lerp(8, 10.95,
    p.life / t.prof_life)
end