class AssembunnyInterpreter
  attr_accessor :registers

  def initialize(registers)
    @ptr = 0
    @registers = registers
  end

  def execute_program(input)
    while(@ptr < input.count)
      @ptr = execute_line(input[@ptr], registers, @ptr)
    end

    nil
  end

  def execute_line(line, registers, ptr)
    instruction = line.split

    case instruction[0]
    when "cpy"
      src = instruction[1]
      src = registers.keys.include?(src) ? registers[src] : src.to_i
      registers[instruction[2]] = src
    when "inc"
      registers[instruction[1]] += 1
    when "dec"
      registers[instruction[1]] -= 1
    end

    if instruction[0] == "jnz"
      src = instruction[1]
      src = registers.keys.include?(src) ? registers[src] : src.to_i
      ptr += (src != 0 ? instruction[2].to_i : 1)
    else
      ptr += 1
    end

    ptr
  end
end
