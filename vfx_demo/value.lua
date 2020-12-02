function get_value(data)
  if data == nil then
    return 0
  elseif type(data) == "number" then
    return data
  else
    return rnd_float(
      data.min,
      data.max)
  end
end