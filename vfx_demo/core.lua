function clamp(v, low, hi)
 	return max(low, min(hi, v))
end

function frac(v)
 	return v - flr(v)
end

function rnd_int(low, hi)
  return flr(
    rnd(hi + 1 - low) + low
  )
end

function rnd_float(low, hi)
  return rnd(hi - low) + low
end