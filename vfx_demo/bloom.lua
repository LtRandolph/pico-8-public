function draw_bloom(self)

  print("extra", 52,52,8)
  print("hot", 52,60,8)
  print("text", 52,68,8)

  bloom_tex = {}
  for y=1,128 do
    row = {}
    for x=1,128 do
      add(row, 0)
    end
    add(bloom_tex, row)
  end

  region_min=64-16
  region_max=65+16

  str = (1 + cos(self.theta)) / 8

  for y=region_min,region_max do
    for x=region_min,region_max do
      col = pget(x-1,y-1)
      bloom_tex[y][x] += col
      if col > 7 then
        for dy=-6,6 do
          ny = y + dy
          for dx=-6,6 do
            nx = x + dx
            if ny>1 and ny<=129 and
              nx>1 and nx<=129 and
              (dx != 0 or dy != 0) then
              alpha = str / (dx*dx +
                      dy*dy)
              bloom_tex[ny][nx] += col * alpha
            end
          end
        end 
      end
    end
  end

  for y=region_min,region_max do
    for x=region_min,region_max do
      pset(x-1,y-1,
        clamp(bloom_tex[y][x],
        0, 15))
    end
  end
end

function add_bloom_pages()
  add(pages, {
    title="bloom",
    init=init_bloom,
    draw=draw_bloom,
    update=update_bloom
  })
end

function init_bloom(self)
  self.theta = 0.5
  activate_blend(blending_additive)
end

function update_bloom(self)
  self.theta += 0.01
  self.theta = frac(self.theta)
end