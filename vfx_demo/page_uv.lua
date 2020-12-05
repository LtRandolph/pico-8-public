function puv_init(self)
  set_palette(palette_rgb)
end

function puv_draw(self)
  sspr(64,32,16,16,
    64-32,64-32,64,64)
end

function add_uv_pages()
  add(pages, {
    title="shapes",
    center_title=true
  })
  add(pages, {
    title="in order to draw more fancy\n"..
      "particles, we need to\n"..
      "interpolate values across\n"..
      "triangles.",
    init=puv_init,
    draw=puv_draw
  })
end