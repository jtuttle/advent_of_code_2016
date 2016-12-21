input = ".^^..^...^..^^.^^^.^^^.^^^^^^.^.^^^^.^^.^^^^^^.^...^......^...^^^..^^^.....^^^^^^^^^....^^...^^^^..^"

SAFE = "."
TRAP = "^"

TRAP_PATTERNS = [
  "#{TRAP}#{TRAP}#{SAFE}",
  "#{SAFE}#{TRAP}#{TRAP}",
  "#{TRAP}#{SAFE}#{SAFE}",
  "#{SAFE}#{SAFE}#{TRAP}"
]

def get_next_row(row)
  next_row = ""
  
  row.each_char.with_index do |char, i|
    prev = ""

    for j in (i-1..i+1) do
      prev << (j < 0 || j >= row.length ? SAFE : row[j])
    end

    next_row << (TRAP_PATTERNS.include?(prev) ? TRAP : SAFE)
  end
  
  next_row
end

def count_safe_tiles(first_row, row_count)
  row = first_row
  safe_tile_count = row.count(SAFE)

  (row_count - 1).times do
    row = get_next_row(row)
    safe_tile_count += row.count(SAFE)
  end

  safe_tile_count
end

puts "Part one has #{count_safe_tiles(input, 40)} safe tiles total."
puts "Part two has  #{count_safe_tiles(input, 400000)} safe tiles total."
