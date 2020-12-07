function pc_init(self)
  init_emitter(self.e)
end

function add_curve_pages()
  add(pages, {
    title="curves",
    center_title=true
  })
  add(pages, {
    title="a valuable tool for making\n"..
      "effects is curves. these let us\n"..
      "input a parameter to get a value\n"..
      "for a particle or emitter.",
    draw=draw_curve
  })
  add(pages, {
    title="inputs are things like time,\n"..
      "speed, position, or random\n"..
      "numbers.\n\n"..
      "outputs are any of the values on\n"..
      "the emitter or particle, like\n"..
      "color, size, or angle.",
    draw=draw_curve
  })
  add(pages, {
    title="we can affect all particles from\n"..
      "an emitter at the same time",
    init=pb_init,
    e={
      burst=512,
      colors={oscillating_col_e},
      radius={
        min=0,
        max=91
      },
      p_life=-1,
      air_resist=0.3,
      accel=oscillating_accel_e
    }
  })
  add(pages, {
    title="or have each particle check the\n"..
      "curve for themselves.",
    init=pb_init,
    e={
      spawn_rate=1,
      colors={oscillating_col_p},
      radius={
        min=0,
        max=91
      },
      p_life=240,
      air_resist=0.3,
      accel=oscillating_accel_p
    }
  })
end

function oscillating_accel_p(e, p)
  return oscillating_accel(p)
end

function oscillating_accel_e(e, p)
  return oscillating_accel(e)
end

function oscillating_accel(v)
  magnitude = 0.3 * (1 +
    sin(v.alive_time / 90))
  angle = rnd(1)
  return magnitude * vec2(
    cos(angle),
    sin(angle)
  )
end

function oscillating_col_p(e, p)
  return oscillating_col(p)
end

function oscillating_col_e(e, p)
  return oscillating_col(e)
end

function oscillating_col(v)
  return flr(9.5 + 1.5 * sin(v.alive_time / 90))
end

function draw_curve()
  color(palette.white)
  line()
  line(16, 55)
  line(16, 110)
  line(71, 110)
  print("o\nu\nt\np\nu\nt",12, 64)
  print("input", 35, 112)

  color(10)
  line()
  for i=17,71 do
    y = (1 + sin(i / 25)) / 2
    line(i, lerp(110, 55, y))
  end
end