input = File.open("day_6_input.txt").readlines.map(&:strip)

freqs = []

def extract_message(freqs, &block)
  freqs.map { |f| yield(f) }.map { |i| i[0] }.join
end

input[0].length.times do
  freqs << Hash.new(0)
end

input.each do |line|
  line.each_char.with_index(0) do |char, i|
    freqs[i][char] += 1
  end
end

puts "Message: #{extract_message(freqs) { |f| f.max_by { |k,v| v } }}"
puts "Decoded message: #{extract_message(freqs) { |f| f.min_by { |k,v| v } }}"
