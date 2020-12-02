vec2mt = {
  __add = function(v1,v2)
    return vec2(v1.x + v2.x, v1.y + v2.y)
  end,
  __sub = function(v1,v2)
    return vec2(v1.x - v2.x, v1.y - v2.y)
  end,
  __unm = function(self)
    return vec2(-self.x, -self.y)
  end,
  __mul = function(s,v)
    return vec2(s * v.x, s * v.y)
  end,
  __len = function(self)
    return sqrt(self.x * self.x + self.y * self.y)
  end,
  __eq = function(v1,v2)
    return v1.x == v2.x and v1.y == v2.y
  end,
  __tostring = function(v)
    return "(" .. v.x .. "," .. v.y .. ")"
  end,
  dot = function(v1,v2)
    return v1.x * v2.x + v1.y * v2.y
  end,
  normalize = function(v)
    len = #v
    if (len == 0) return
    v.x /= len
    v.y /= len
  end
}
vec2mt.__index = vec2mt

function vec2(x,y)
  return setmetatable({x = x, y = y},vec2mt)
end