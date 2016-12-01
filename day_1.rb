input = "R3, L2, L2, R4, L1, R2, R3, R4, L2, R4, L2, L5, L1, R5, R2, R2, L1, R4, R1, L5, L3, R4, R3, R1, L1, L5, L4, L2, R5, L3, L4, R3, R1, L3, R1, L3, R3, L4, R2, R5, L190, R2, L3, R47, R4, L3, R78, L1, R3, R190, R4, L3, R4, R2, R5, R3, R4, R3, L1, L4, R3, L4, R1, L4, L5, R3, L3, L4, R1, R2, L4, L3, R3, R3, L2, L5, R1, L4, L1, R5, L5, R1, R5, L4, R2, L2, R1, L5, L4, R4, R4, R3, R2, R3, L1, R4, R5, L2, L5, L4, L1, R4, L4, R4, L4, R1, R5, L1, R1, L5, R5, R1, R1, L3, L1, R4, L1, L4, L4, L3, R1, R4, R1, R1, R2, L5, L2, R4, L1, R3, L5, L2, R5, L4, R5, L5, R3, R4, L3, L3, L2, R2, L5, L5, R3, R4, R3, R4, R3, R1".split(", ")

dir = "N"
pos = [0, 0]

def turn(current_dir, turn_dir)
  dirs = ["N", "E", "S", "W"]
  current_idx = dirs.find_index(current_dir)
  return dirs[(current_idx + (turn_dir == "L" ? -1 : 1)) % 4]
end

def walk(pos, dir, dist)
  x = pos[0]
  y = pos[1]

  case dir
    when "N"
      y += dist
    when "E"
      x += dist
    when "S"
      y -= dist
    when "W"
      x -= dist
  end

  [x, y]
end

input.each do |i|
  puts "next input: #{i}"

  puts "started at: #{pos[0]},#{pos[1]} facing #{dir}"

  dir = turn(dir, i[0])
  pos = walk(pos, dir, i[1..-1].to_i)

  puts "ended at: #{pos[0]},#{pos[1]} facing #{dir}"
end

puts "Total distance: #{pos[0].abs + pos[1].abs}"
