input = File.open("day_3_input.txt").readlines

def is_valid_triangle?(a, b, c)
  puts "checking #{a}, #{b}, #{c}"
  
  a + b > c && a + c > b && b + c > a
end

def valid_by_rows(input)
  valid_count = 0
  
  input.each do |line|
    sides = line.split(" ")

    if is_valid_triangle?(sides[0].to_i, sides[1].to_i, sides[2].to_i)
      valid_count += 1
    end
  end

  valid_count
end

def valid_by_columns(input)
  valid_count = 0

  input.each_slice(3) do |lines|
    split_lines = lines.map(&:split)
    
    for i in (0..2) do
      if is_valid_triangle?(split_lines[0][i].to_i,
                            split_lines[1][i].to_i,
                            split_lines[2][i].to_i)
        valid_count += 1
      end
    end
  end

  valid_count
end

puts "Valid triangles by row: #{valid_by_rows(input)}"
puts "Valid triangles by col: #{valid_by_columns(input)}"
