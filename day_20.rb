input = File.open("day_20_input.txt").readlines

lowest_allowed = 0
highest_allowed = 0

sorted_input = 
  input.map { |line| line.split('-').map(&:to_i) }.
  sort_by { |i| i[0] }

sorted_input.each do |pair|
  low = pair[0]
  high = pair[1]

  lowest_allowed = high if lowest_allowed >= low
end

puts lowest_allowed
