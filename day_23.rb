require_relative 'assembunny_interpreter'

input = File.open("day_23_input.txt").readlines

interpreter = AssembunnyInterpreter.new({ "a" => 7, "b" => 0, "c" => 0, "d" => 0 })
interpreter.execute_program(input)
puts "Part one: #{interpreter.registers}"
