Dir['./day_11/*.rb'].each{ |f| require f }

input = File.open("day_11_input.txt").readlines

bldg = Building.new
bldg.parse(input)
bldg.print
