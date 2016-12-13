input = File.open("day_11_input.txt").readlines

@print_index = []

class Equipment
  attr_reader :element, :type

  def initialize(element, type)
    @element = element
    @type = type
  end

  def to_s
    "#{element[0].capitalize}#{type.to_s[0].capitalize}"
  end
end

def print_floors(floors, elevator_level)
  (0...floors.count).reverse_each do |i|
    floor = floors[i]

    floor_str = "F#{i + 1} #{elevator_level == i ? 'E ' : '. '}"

    @print_index.each do |e|
      floor_str << "#{floor.include?(e) ? e.to_s + ' ' : '.  '}"
    end

    puts floor_str
  end
end

def init(input)
  floors = []

  input.each do |line|
    floor = []
    floors << floor

    equipment = line.split("contains")[1].split(",")
    
    line.scan(/(\w+) generator/).flatten.each do |element|
      floor << Equipment.new(element, :generator)
    end

    line.scan(/(\w+)-compatible microchip/).flatten.each do |element|
      floor << Equipment.new(element, :microchip)
    end

    @print_index.concat(floor)
  end

  @print_index.sort_by!(&:element)

  floors
end

floors = init(input)
elevator_level = 0

print_floors(floors, elevator_level)
