function dump(any, depth)
  local depth = depth or 0
  local indent = ""
  for i=1,depth do
    indent = indent .. " "
  end

  if type(any)=="function" then 
    return "function" 
  end
  if any==nil then 
    return "nil" 
  end
  if type(any)=="string" then
    return any
  end
  if type(any)=="boolean" then
    if any then return "true" end
    return "false"
  end
  if type(any)=="number" then
    return ""..any
  end
  if type(any)=="table" then
    local str = "\n" .. indent .. "{"
    for k,v in pairs(any) do
      str=str.."\n"..
      indent.." "..
      dump(k, depth + 1)
      .." : "..
      dump(v, depth + 1)
    end
    return str.."\n"..indent.."}"
  end
  return any:__tostring()
end