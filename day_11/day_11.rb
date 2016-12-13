input = File.open("day_11_input.txt").readlines

class Building
  attr_reader :floors, :elevator_level

  def self.clone(building)

  end

  def initialize
    @elevator_level = 0
    @floors = []
    @manifest = []
  end

  def is_valid?
    !@floors.map(&:is_valid?).include?(false)
  end

  def parse(input)
    input.each do |line|
      floor = []
      @floors << floor

      line.scan(/(\w+) generator/).flatten.each do |element|
        floor << Equipment.new(element, :generator)
      end

      line.scan(/(\w+)-compatible microchip/).flatten.each do |element|
        floor << Equipment.new(element, :microchip)
      end

      @manifest.concat(floor)
    end

    @manifest.sort_by!(&:element)    
  end

  def print
    (0...@floors.count).reverse_each do |i|
      floor = @floors[i]

      floor_str = "F#{i + 1} #{elevator_level == i ? 'E   ' : '.   '}"

      @manifest.each do |e|
        floor_str << "#{floor.include?(e) ? e.to_s + '  ' : '.    '}"
      end

      puts floor_str
    end

    nil
  end
end

class Floor
  def initialize
    @equipment = []
  end

  def valid?
    microchips = @equipment.select { |e| e.type == :microchip }
    
    microchips.each do |microchip|
      if is_endangered?(microchip) && !is_shielded?(microchip)
        return false
      end
    end

    true
  end

  def is_shielded?(microchip)
    !@equipment.select { |e|
      e.type == :generator && e.element == microchip.element
    }.empty?
  end

  def is_endangered?(microchip)
    !@equipment.select {
      |e| e.type == :generator && e.element != microchip.element
    }.empty?
  end
end

class Equipment
  attr_reader :element, :type

  def initialize(element, type)
    @element = element
    @type = type
  end

  def to_s
    "#{element[0].capitalize}#{element[1]}#{type.to_s[0].capitalize}"
  end
end

=begin
def is_goal_state?(floors)
  floors.last.sort_by(&:element) == @print_index &&
    !floors[0...-1].map(&:empty?).include?(false)
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

def generate_next_states(floors, elevator_level)

end

floors = init(input)
elevator_level = 0

print_floors(floors, elevator_level)
puts is_valid?(floors)
puts is_goal_state?(floors)
=end

bldg = Building.new
bldg.parse(input)
bldg.print
