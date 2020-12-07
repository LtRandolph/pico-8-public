palette_blendable={
  0,130,132,4,137,9,10,135,
  7,7,7,7,7,7,7,7,
  white=8
}

palette_grayscale={
  0,128,133,5,13,6,7,7,
  7,7,7,7,7,7,7,7,
  white=6
}

palette_default={
  0,1,2,3,4,5,6,7,
  8,9,10,11,12,13,14,15,
  white=7
}

palette_cotton_candy={
  0,140,12,14,14,14,7,
  7,7,7,7,7,7,7,7,
  white=7
}

palette_plasma={
  0,12,0,0,0,0,0,0,
  0,0,0,0,0,0,0,7,
  white=15
}

palette_smoky={
  0,128,128,133,5,134,134,6,
  7,7,7,7,7,7,7,7,
  white=15
}

palette_bush={
  0,3,3,3,11,11,11,3,
  7,7,7,7,7,7,7,7,
  white=15
}

palette_rgb={
  0,3,139,11,12,140,8,9,
  135,138,136,2,141,131,7,7,
  white=15
}

function set_palette(_pal)
  palette = _pal
  for i,c in pairs(_pal) do
    if type(i) == "number" then
      pal(i-1,c,1)
    end
  end
end