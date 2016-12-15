require_relative 'a_star'

@input = 1358

Struct.new("Point", :x, :y)

def is_open?(point)
  x = point.x
  y = point.y

  return false if x < 0 || y < 0

  (x*x + 3*x + 2*x*y + y + y*y + @input).to_s(2).count('1') % 2 == 0
end

def get_neighbors(point)
  neighbors = []

  x = point.x
  y = point.y

  [-1, 1].each do |i|
    new_point = Struct::Point.new(x + i, y)
    neighbors << new_point if is_open?(point)
    
    new_point = Struct::Point.new(x, y + i)
    neighbors << new_point if is_open?(point)
  end

  neighbors
end

def draw_floor(width, height, path = nil)
  for y in (0...width)
    row = ""
    for x in (0...width)
      point = Struct::Point.new(x, y)

      symbol =
        if !path.nil? && path.include?(point)
          'O'
        elsif is_open?(point)
          '.'
        else
          '#'
        end

      row << symbol
    end

    puts row
  end

  nil
end

def manhattan_distance(p1, p2)
  (p1.x - p2.x).abs + (p1.y - p2.y).abs
end

start = Struct::Point.new(1, 1)
goal = Struct::Point.new(31, 39)
neighbor_proc = Proc.new { |point| get_neighbors(point) }
heuristic_proc = Proc.new { |point, goal| manhattan_distance(point, goal) }

search = AStar.new(start, goal, neighbor_proc, heuristic_proc)
path = search.execute

puts "Number of steps: #{path.count - 1}"

