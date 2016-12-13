require 'building'
require 'floor'
require 'eqiupment'

input = File.open("day_11_input.txt").readlines

bldg = Building.new
bldg.parse(input)
bldg.print
