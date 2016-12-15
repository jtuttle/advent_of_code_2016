require_relative 'a_star'

input = 1358

Struct.new("Point", :x, :y)

def is_open?(point, num)
  x = point.x
  y = point.y
  (x*x + 3*x + 2*x*y + y + y*y + num).to_s(2).count('1') % 2 == 0
end

def draw_floor(width, height, input)
  for y in (0...width)
    row = ""
    for x in (0...width)
      point = Struct::Point.new(x, y)
      row << (is_open?(point, input) ? '.' : '#')
    end

    puts row
  end

  nil
end

def manhattan(p1, p2)
  (p1.x - p2.x).abs + (p1.y - p2.y).abs
end

puts draw_floor(10, 10, 10)

