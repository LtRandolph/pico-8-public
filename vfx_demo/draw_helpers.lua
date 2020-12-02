function draw_sprite(s,
  p_min, p_max, alpha)

  s_min = vec2(
    8 * (s % 16),
    8 * (s \ 16)
  )

  range = p_max - p_min

  sspr(s_min.x, s_min.y, 8, 8,
    p_min.x, p_min.y,
    range.x, range.y)
end

draw_sprite_alpha = draw_sprite
draw_sprite_additive = draw_sprite

function aligned_rect(col,
  p_min, p_max, alpha)
  rectfill(p_min.x, p_min.y,
    p_max.x, p_max.y, col)
end

function aligned_rect_alpha(col,
  p_min, p_max, alpha)
  for y=p_min.y,p_max.y do
    for x=p_min.x,p_max.x do
      cur = pget(x,y)
      new = lerp(
        cur, col, alpha
      )
      new = round(new)
      pset(x, y, new)
    end
  end
end

function aligned_rect_additive(
  col, p_min, p_max, alpha)
  for y=p_min.y,p_max.y do
    for x=p_min.x,p_max.x do
      cur = pget(x,y)
      new = cur + col * alpha
      new = round(new)
      new = clamp(new, 0, 15)
      pset(x, y, new)
    end
  end
end

function rotate_vec2(v, s, c,
  center)
  return center + vec2(
    c * (v.x - center.x) -
    s * (v.y - center.y),
    s * (v.x - center.x) +
    c * (v.y - center.y)
  )
end

function rotated_rect(col,
  p_min, p_max, angle, alpha)
  center = 0.5 * (p_max + p_min)

  s = sin(angle)
  c = cos(angle)

  corner_1 =
    vec2(p_min.x, p_max.y)
  corner_2 =
    vec2(p_max.x, p_min.y)

  rot_p ={
    rotate_vec2(p_min,
    s, c, center),
    rotate_vec2(corner_1,
    s, c, center),
    rotate_vec2(p_max,
    s, c, center),
    rotate_vec2(corner_2,
    s, c, center)
  }

  min_x_p = rot_p[1]
  max_y_p = rot_p[2]
  max_x_p = rot_p[3]
  min_y_p = rot_p[4]
  for i=2,4 do
    if rot_p[i].x < min_x_p.x then
      min_x_p = rot_p[i]
      max_y_p = rot_p[i%4 + 1]
      max_x_p = rot_p[(i+1)%4 + 1]
      min_y_p = rot_p[(i+2)%4 + 1]
    end
  end

  total_y = max_y_p.y - min_y_p.y

  y_to_min_x = min_x_p.y - min_y_p.y
  y_from_min_x = max_y_p.y - min_x_p.y
  y_to_max_x = max_x_p.y - min_y_p.y
  y_from_max_x = max_y_p.y - max_x_p.y
  for y=ceil(min_y_p.y),flr(max_y_p.y) do
    y_up = y - min_y_p.y

    t_min_x = y_up / y_to_min_x
    if t_min_x < 1 then
      min_x = lerp(min_y_p.x,
        min_x_p.x, t_min_x)
    else
      t_min_x = (y - min_x_p.y) /
        y_from_min_x
      min_x = lerp(min_x_p.x,
        max_y_p.x, t_min_x)
    end

    t_max_x = y_up / y_to_max_x
    if t_max_x < 1 then
      max_x = lerp(min_y_p.x,
        max_x_p.x, t_max_x)
    else
      t_max_x = (y - max_x_p.y) /
        y_from_max_x
      max_x = lerp(max_x_p.x,
        max_y_p.x, t_max_x)
    end

    line(min_x, y, max_x, y, col)
  end
end

rotated_rect_alpha = rotated_rect
rotated_rect_additive = rotated_rect