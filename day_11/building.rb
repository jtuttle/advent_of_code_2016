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
