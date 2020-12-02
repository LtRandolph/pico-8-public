function draw_sprite(s,
  p_min, p_max)

  s_min = vec2(
    8 * (s % 16),
    8 * (s \ 16)
  )

  range = p_max - p_min

  sspr(s_min.x, s_min.y, 8, 8,
    p_min.x, p_min.y,
    range.x, range.y)
end