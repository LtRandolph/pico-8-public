function init_pages()
  pages = {}
  paused = false
  add_basic_pages()
  add_uv_pages()
  add_texture_pages()
  add_model_pages()
  add_emitter_pages()
  add_effect_pages()
  add_curve_pages()
  --add_blend_pages()
  add_palette_pages()
  add_trail_pages()
  add_screen_pages()
  add_bloom_pages()

  page_num = 1
  init_page()
end

function init_page()
  reset_effects()
  page_step=1

  page = pages[page_num]

  if (page.init) page:init()
end

function update_pages()
  local last = page_num

  if (btnp(2)) page_num -= 1
  if (btnp(3)) page_num += 1
  page_num = clamp(page_num,
    1, #pages)

  if last != page_num or
    btnp(5) then
    init_page()
  end

  if btnp(4) then
    paused = not paused
  end

  if not paused and page.update then
    page:update()
  end
end

function draw_pages()
  print(page.title, 1, 1, 
    palette.white)

  if page.draw then
    page:draw()
  end
end