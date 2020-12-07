function clamp(v, low, hi)
 	return max(low, min(hi, v))
end

function frac(v)
 	return v - flr(v)
end

function lerp(v1, v2, a)
  return (1 - a) * v1 + a * v2
end

function round(v)
  return flr(v + 0.5)
end

function rnd_int(low, hi)
  return flr(
    rnd(hi + 1 - low) + low
  )
end

function rnd_float(low, hi)
  return rnd(hi - low) + low
end