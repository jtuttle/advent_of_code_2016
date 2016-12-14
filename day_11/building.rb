class Building
  attr_reader :floors, :elevator_level

  def initialize(elevator_level = 0)
    @elevator_level = elevator_level
    @floors = []
    @manifest = []
  end

  def valid?
    @floors.each do |floor|
      microchips = floor.select { |e| e.type == :microchip }
      
      microchips.each do |microchip|
        endangered =
          !floor.select { |e|
            e.type == :generator && e.element != microchip.element
          }.empty?
        
        if endangered
          shielded  =
            !floor.select { |e|
              e.type == :generator && e.element == microchip.element
            }.empty?
          
          return false unless shielded
        end
      end
    end

    true
  end

  def add_floor
    new_floor = []
    @floors << new_floor
    new_floor
  end

  def add_equipment_to_floor(equipment, floor)
    floor << equipment
    @manifest << equipment
    @manifest.sort_by!(&:element)
  end

  def parse(input)
    input.each do |line|
      floor = add_floor

      line.scan(/(\w+) generator/).flatten.each do |element|
        add_equipment_to_floor(Equipment.new(element, :generator), floor)
      end

      line.scan(/(\w+)-compatible microchip/).flatten.each do |element|
        add_equipment_to_floor(Equipment.new(element, :microchip), floor)
      end
    end
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

  def clone
    clone = Building.new(@elevator_level)

    @floors.each do |floor|
      cloned_floor = clone.add_floor

      floor.each do |equipment|
        clone.add_equipment_to_floor(equipment, cloned_floor)
      end
    end
    
    clone
  end
end
