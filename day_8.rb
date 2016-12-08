input = File.open("day_8_input.txt").readlines

WIDTH = 60
HEIGHT = 5

def rect(w, h, screen)
  for i in (0...w) do
    for j in (0...h) do
      screen[j * WIDTH + i] = '#'
    end
  end
end

def rotate_row(num, val, screen)

end

def rotate_col(num, val, screen)

end

def print_screen(screen)
  for y in (0...HEIGHT) do

  end
end

input.each do |line|
  split_line = line.split
  screen = ['.'] * (WIDTH * HEIGHT)

  if split_line[0] == "rect"
    values = split_line[1].split('x')
    rect(values[0], values[1], screen)
  else
    
  end

  
end
