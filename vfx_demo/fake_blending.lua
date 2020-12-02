blending_default = {
  draw_sprite = draw_sprite,
  rotated_rect = rotated_rect,
  aligned_rect = aligned_rect
}

blending_alpha = {
  draw_sprite = draw_sprite_alpha,
  rotated_rect = rotated_rect_alpha,
  aligned_rect = aligned_rect_alpha
}

blending_additive = {
  draw_sprite = draw_sprite_additive,
  rotated_rect = rotated_rect_additive,
  aligned_rect = aligned_rect_additive
}

function reset_blending()
  pal()
  blending = blending_default
end

function set_blendable_palette()
  _pal={0,130,132,4,137,9,10,135,7,7,7,7,7,7,7,7}
  for i,c in pairs(_pal) do
    pal(i-1,c,1)
  end
end

function activate_alpha_blending()
  set_blendable_palette()
  blending = blending_alpha
end

function activate_additive_blending()
  set_blendable_palette()
  blending = blending_additive
end