input = File.open("day_9_input.txt").read.strip

def decompressed_length(str, v2)
  i = 0
  length = 0

  while i < str.length
    if str[i] == '('
      i += 1
      
      # Read the marker
      marker = ""

      while str[i] != ')'
        marker << str[i]
        i += 1
      end

      # Move to next char after closing paren
      i += 1

      # Append repeated string
      repeat_length = marker.split('x')[0].to_i
      repeat_count = marker.split('x')[1].to_i
      repeat_end = [i + repeat_length, str.length].min

      # Handle v2 with recursion
      if v2
        length += decompressed_length(str[i...repeat_end], v2) * repeat_count
      else
        length += str[i...repeat_end].length * repeat_count
      end
      
      i += repeat_length
    else
      length += 1
      i += 1
    end
  end

  length
end

puts "Decompressed length (v1) is: #{decompressed_length(input, false)}"
puts "Decompressed length (v2) is: #{decompressed_length(input, true)}"
