function get_value(data, default)
  if data == nil then
    return default or 0
  elseif type(data) == "number" then
    return data
  elseif data.x != nil then
    return data
  else
    return rnd_float(
      data.min,
      data.max)
  end
end