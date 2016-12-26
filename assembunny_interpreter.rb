class AssembunnyInterpreter
  attr_accessor :registers

  def initialize(registers)
    @ptr = 0
    @registers = registers
  end

  def execute_program(lines)
    while(@ptr < lines.count)
      line = lines[@ptr]
      instruction = line.split[0]

      if instruction == "tgl"
        execute_toggle(line, lines)
      else
        execute_line(line)
      end
    end
    
    nil
  end

  def execute_line(line)
    split_line = line.split

    case split_line[0]
    when "cpy"
      src = read_value(split_line[1])
      @registers[split_line[2]] = src
    when "inc"
      @registers[split_line[1]] += 1
    when "dec"
      @registers[split_line[1]] -= 1
    end

    if split_line[0] == "jnz"
      src = read_value(split_line[1])
      @ptr += (src != 0 ? split_line[2].to_i : 1)
    else
      @ptr += 1
    end

    nil
  end

  def read_value(val)
    @registers.keys.include?(val) ? @registers[val] : val.to_i
  end

  def execute_toggle(toggle_instruction, lines)
    toggle_instruction_split = toggle_instruction.split
    target_index = @ptr + read_value(toggle_instruction_split[1])
    target_instruction = lines[target_index]

puts toggle_instruction
puts "register c is #{read_value(toggle_instruction_split[1])}"
    puts "ptr is #{@ptr}"


    @ptr += 1

    nil
  end
end
