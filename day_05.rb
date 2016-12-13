require 'digest'

input = "ugkcyxxp"

def part_one(door_id)
  password = ""
  num = 0

  while password.length < 8 do
    hash = Digest::MD5.hexdigest(door_id + num.to_s)

    if hash[0..4] == "00000"
      #puts "*** Found #{hash[5]}"
      password << hash[5]
    end

    num += 1
  end

  password
end

def part_two(door_id)
  password = [nil] * 8
  num = 0

  while password.compact.join.length != 8 do
    hash = Digest::MD5.hexdigest(door_id + num.to_s)

    if hash[0..4] == "00000" && (0...8).include?(hash[5].to_i)
      pos = hash[5]

      if (0...8).map(&:to_s).include?(hash[5])
        if password[hash[5].to_i].nil?
          #puts "Setting pos #{hash[5]} to #{hash[6]}: (#{password.join})"
          password[hash[5].to_i] = hash[6]
        end
      end
    end

    num += 1
  end
  
  password.join
end

puts "Finding part one password..."
puts "Part one password: #{part_one(input)}"
puts "Finding part two password..."
puts "Part two password: #{part_two(input)}"
