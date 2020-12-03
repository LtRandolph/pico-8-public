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

function set_palette(_pal)
  palette = _pal
  for i,c in pairs(_pal) do
    if type(i) == "number" then
      pal(i-1,c,1)
    end
  end
end