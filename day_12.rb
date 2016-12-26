require_relative 'assembunny_interpreter'

input = File.open("day_12_input.txt").readlines

interpreter = AssembunnyInterpreter.new({ "a" => 0, "b" => 0, "c" => 0, "d" => 0 })
interpreter.execute_program(input)
puts "Part one: #{interpreter.registers}"

interpreter = AssembunnyInterpreter.new({ "a" => 0, "b" => 0, "c" => 1, "d" => 0 })
interpreter.execute_program(input)
puts "Part two: #{interpreter.registers}"
