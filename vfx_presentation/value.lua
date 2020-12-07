function get_value(e, p, data,
  default)
  if data == nil then
    return default or 0
  elseif type(data) == "function" then
    return data(e, p)
  elseif type(data) == "number" then
    return data
  elseif data.x != nil then
    return data:copy()
  elseif type(data.min) == "number" then
    return rnd_float(
      data.min,
      data.max)
  else
    return vec2(rnd_float(
      data.min.x, data.max.x
    ),
    rnd_float(
      data.min.y, data.max.y
    ))
  end
end