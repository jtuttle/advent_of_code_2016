input = File.open("day_12_input.txt").readlines

def run_program(lines, registers)
  ptr = 0

  register_keys = registers.keys

  while(ptr < lines.count)
    instruction = lines[ptr].split

    case instruction[0]
    when "cpy"
      src = instruction[1]
      src = register_keys.include?(src) ? registers[src] : src.to_i
      registers[instruction[2]] = src
    when "inc"
      registers[instruction[1]] += 1
    when "dec"
      registers[instruction[1]] -= 1
    end

    if instruction[0] == "jnz"
      src = instruction[1]
      src = register_keys.include?(src) ? registers[src] : src.to_i
      ptr += (src != 0 ? instruction[2].to_i : 1)
    else
      ptr += 1
    end
  end

  nil
end

registers = { "a" => 0, "b" => 0, "c" => 0, "d" => 0 }
run_program(input, registers)
puts "Part one: #{registers}"

registers = { "a" => 0, "b" => 0, "c" => 1, "d" => 0 }
run_program(input, registers)
puts "Part two: #{registers}"
