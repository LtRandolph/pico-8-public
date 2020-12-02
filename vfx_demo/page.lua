pages = {
  {
    title="test",
    init=pb_init,
    step_change=pb_init,
    steps=4
  }
}

function init_pages()
  page_num = 1
  init_page()
end

function init_page()
  reset_effects()
  page_step=1

  pages[page_num]:init()
  page = pages[page_num]
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

  last = page_step
  if (btnp(0)) page_step -= 1
  if (btnp(1)) page_step += 1
  page_step = clamp(page_step,
    1, page.steps)

  if (last != page_step or
    btnp(4)) and
    page.step_change then
    page.step_change()
  end

  if page.update then
    page.update()
  end
end

function draw_pages()
  print(page.title, 1, 1, 7)

  if page.draw then
    page.draw()
  end
end