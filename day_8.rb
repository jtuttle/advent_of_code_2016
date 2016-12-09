input = File.open("day_8_input.txt").readlines

WIDTH = 50
HEIGHT = 6

def rect(w, h, screen)
  for i in (0...w) do
    for j in (0...h) do
      screen[j * WIDTH + i] = '#'
    end
  end
end

def rotate_row(y, amount, screen)
  start_idx = y * WIDTH
  last_idx = start_idx + WIDTH
  old_values = screen[start_idx...start_idx + WIDTH]

  for i in (start_idx...last_idx) do
    screen[i] = old_values[(i - amount) % WIDTH]
  end
end

def rotate_col(x, amount, screen)
  old_values = []

  for i in (0...HEIGHT) do
    old_values << screen[i * WIDTH + x]
  end

  for i in (0...HEIGHT) do
    screen[i * WIDTH + x] = old_values[(i - amount) % HEIGHT]
  end
end

def print_screen(screen)
  for y in (0...HEIGHT) do
    start_idx = y * WIDTH
    puts screen[start_idx...start_idx + WIDTH].join(' ')
  end
end

def count_lit_pixels(screen)
  
end

screen = ['.'] * (WIDTH * HEIGHT)

input.each do |line|
  split_line = line.split

  if split_line[0] == "rect"
    values = split_line[1].split('x')
    rect(values[0].to_i, values[1].to_i, screen)
  else
    row_or_col = 
    rotate_target = split_line[2].split('=')[1].to_i
    rotate_amount = split_line[4].to_i
    
    if split_line[1] == "row"
      rotate_row(rotate_target, rotate_amount, screen)
    elsif split_line[1] == "column"
      rotate_col(rotate_target, rotate_amount, screen)      
    end
  end
end

print_screen(screen)

puts "Lit pixel count: #{screen.count("#")}"
