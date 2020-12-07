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
  set_palette(palette_default)
  blending = blending_default
end

function activate_blend(blend)
  set_palette(palette_blendable)
  blending = blend
end