input = File.readlines("day_2_input.txt")

def row_min(n)
  ((n - 1) / 3) * 3 + 1
end

def row_max(n)
  ((n - 1) / 3 + 1) * 3
end

def find_square_code(input, start_pos)
  pos = start_pos
  code = ""

  input.each do |line|
    line.each_char do |dir|
      case dir
        when "L"
          pos = pos - 1 if pos - 1 >= row_min(pos)
        when "R"
          pos = pos + 1 if pos + 1 <= row_max(pos)
        when "U"
          pos = pos - 3 if pos - 3 >= 1
        when "D"
          pos = pos + 3 if pos + 3 <= 9
      end
    end

    code << pos.to_s
  end

  code
end

def find_irregular_code(input, layout, row_width, start_pos)
  index = layout.find_index(start_pos)
  code = ""

  input.each do |line|
    line.each_char do |dir|
      case dir
        when "L"
          index = index - 1 if layout[index - 1] != "x"
        when "R"
          index = index + 1 if layout[index + 1] != "x"
        when "U"
          index = index - row_width if layout[index - row_width] != "x"
        when "D"
          index = index + row_width if layout[index + row_width] != "x"
      end
    end

    code << layout[index].to_s
  end

  code
end

keypad =
"xxxxxxx" \
"xxx1xxx" \
"xx234xx" \
"x56789x" \
"xxABCxx" \
"xxxDxxx" \
"xxxxxxx"

puts "Square Code is #{find_square_code(input, 5)}"
puts "Irregular Code is #{find_irregular_code(input, keypad.split(//), 7, "5")}"
