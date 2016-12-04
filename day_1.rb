input = File.open("day_1_input.txt").readlines.join.split(" ")

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
