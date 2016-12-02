input = "R3, L2, L2, R4, L1, R2, R3, R4, L2, R4, L2, L5, L1, R5, R2, R2, L1, R4, R1, L5, L3, R4, R3, R1, L1, L5, L4, L2, R5, L3, L4, R3, R1, L3, R1, L3, R3, L4, R2, R5, L190, R2, L3, R47, R4, L3, R78, L1, R3, R190, R4, L3, R4, R2, R5, R3, R4, R3, L1, L4, R3, L4, R1, L4, L5, R3, L3, L4, R1, R2, L4, L3, R3, R3, L2, L5, R1, L4, L1, R5, L5, R1, R5, L4, R2, L2, R1, L5, L4, R4, R4, R3, R2, R3, L1, R4, R5, L2, L5, L4, L1, R4, L4, R4, L4, R1, R5, L1, R1, L5, R5, R1, R1, L3, L1, R4, L1, L4, L4, L3, R1, R4, R1, R1, R2, L5, L2, R4, L1, R3, L5, L2, R5, L4, R5, L5, R3, R4, L3, L3, L2, R2, L5, L5, R3, R4, R3, R4, R3, R1".split(", ")

dir = "N"
pos = [0, 0]
visits = {"0,0" => 1}
first_revisit = nil

def turn(current_dir, turn_dir)
  dirs = ["N", "E", "S", "W"]
  current_idx = dirs.find_index(current_dir)
  return dirs[(current_idx + (turn_dir == "L" ? -1 : 1)) % 4]
end

def step(pos, dir)
  x = pos[0]
  y = pos[1]

  case dir
    when "N"
      y += 1
    when "E"
      x += 1
    when "S"
      y -= 1
    when "W"
      x -= 1
  end

  [x, y]
end

input.each do |i|
  puts "next input: #{i}"

  puts "started at: #{pos[0]},#{pos[1]} facing #{dir}"

  dir = turn(dir, i[0])
  dist = i[1..-1].to_i

  for n in (0...dist) do
    pos = step(pos, dir)

    visit_key = "#{pos[0]},#{pos[1]}"

    if first_revisit.nil? && visits.include?(visit_key)
      puts "made first revisit at: #{visit_key}"
      first_revisit = pos
    end

    visits[visit_key] = 0 unless visits.include?(visit_key)
    visits[visit_key] += 1
  end

  puts "ended at: #{pos[0]},#{pos[1]} facing #{dir}"
end

puts "--------------------------------"
puts "Total distance: #{pos[0].abs + pos[1].abs}"
puts "First revisit distance: #{first_revisit[0].abs + first_revisit[1].abs}"
