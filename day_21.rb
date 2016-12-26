input = File.open("day_21_input.txt").readlines

def swap_pos(str, a, b)
  tmp = str[a]
  str[a] = str[b]
  str[b] = tmp
  str
end

def swap_char(str, a, b)
  str.tr("#{a}#{b}", "#{b}#{a}")
end

def rotate_left(str, n)
  new_str = ""
  
  for i in (0...str.size)
    new_str << str[(n + i) % str.size]
  end

  new_str
end

def rotate_right(str, n)
  new_str = ""
  
  for i in (0...str.size)
    new_str << str[(-n + i) % str.size]
  end

  new_str
end

def rotate_by_index(str, letter)
  index = str.index(letter)
  rotation_amount = (index + 1) + (index >= 4 ? 1 : 0)
  rotate_right(str, rotation_amount)
end

def reverse_rotate_by_index(str, letter)
  index = str.index(letter)
  
  if index % 2 != 0
    new_index = (index - 1) / 2
  else
    new_index = (((index - 2) % str.size + str.size) / 2)
  end

  delta = new_index - index

  if delta < 0
    rotate_left(str, delta.abs)
  elsif delta > 0
    rotate_right(str, delta)
  else
    str
  end
end

def reverse_span(str, x, y)
  str[x..y] = str[x..y].reverse
  str
end

def move_position(str, x, y)
  char = str.slice!(x)
  "#{str[0...y]}#{char}#{str[y..-1]}"
end

def process_line(str, line)
  split_line = line.split(' ')
  command = split_line[0..1].join(' ')

  case command
  when "swap position"
    swap_pos(str, split_line[2].to_i, split_line[5].to_i)
  when "swap letter"
    swap_char(str, split_line[2], split_line[5])
  when "rotate left"
    rotate_left(str, split_line[2].to_i)
  when "rotate right"
    rotate_right(str, split_line[2].to_i)
  when "rotate based"
    rotate_by_index(str, split_line[6])
  when "reverse positions"
    reverse_span(str, split_line[2].to_i, split_line[4].to_i)
  when "move position"
    move_position(str, split_line[2].to_i, split_line[5].to_i)
  end
end

def reverse_line(str, line)
  split_line = line.split(' ')
  command = split_line[0..1].join(' ')

  case command
  when "swap position"
    swap_pos(str, split_line[5].to_i, split_line[2].to_i)
  when "swap letter"
    swap_char(str, split_line[5], split_line[2])
  when "rotate left"
    rotate_right(str, split_line[2].to_i)
  when "rotate right"
    rotate_left(str, split_line[2].to_i)
  when "rotate based"
    reverse_rotate_by_index(str, split_line[6])
  when "reverse positions"
    reverse_span(str, split_line[2].to_i, split_line[4].to_i)
  when "move position"
    move_position(str, split_line[5].to_i, split_line[2].to_i)
  end
end

password = "abcdefgh"

input.each do |line|
  password = process_line(password.dup, line)
end

puts "Scrambled password is #{password}"

password = "fbgdceah"

input.reverse.each do |line|
  password = reverse_line(password.dup, line)
end

puts "Unscrambled password is #{password}"
