input = 1358

def is_open?(x, y, num)
  (x*x + 3*x + 2*x*y + y + y*y + num).to_s(2).count('1') % 2 == 0
end

def draw_floor(width, height, input)
  for y in (0...width)
    row = ""
    for x in (0...width)
      row << (is_open?(x, y, input) ? '.' : '#')
    end

    puts row
  end

  nil
end

puts draw_floor(10, 10, 10)
