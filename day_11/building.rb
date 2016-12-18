require 'digest/sha1'

class Building
  attr_reader :floors, :elevator_level

  def initialize(elevator_level = 0)
    @elevator_level = elevator_level
    @floors = []
    @manifest = []
  end

  def current_floor
    floors[@elevator_level]
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
    @floors << []
  end

  def add_equipment_to_floor(equipment, floor_index)
    @floors[floor_index] << equipment
    @manifest << equipment
    @manifest.sort_by!(&:element)
  end

  def move_equipment(equipment, from, to)
    equipment.each do |e|
      @floors[to] << e
      @floors[from].delete(e)
    end

    @elevator_level = to
  end

  def parse(input)
    for i in (0...input.count) do
      line = input[i]
      floor = add_floor

      line.scan(/(\w+) generator/).flatten.each do |element|
        add_equipment_to_floor(Equipment.new(element, :generator), i)
      end

      line.scan(/(\w+)-compatible microchip/).flatten.each do |element|
        add_equipment_to_floor(Equipment.new(element, :microchip), i)
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

    for i in (0...@floors.count) do
      floor = @floors[i]
      clone.add_floor

      floor.each do |equipment|
        clone.add_equipment_to_floor(equipment, i)
      end
    end
    
    clone
  end

  def ==(other)
    hash_key == other.hash_key
  end

  def equals?(other)
    self == other
  end
  
  def eql?(other)
    self == other
  end

  def hash
    Digest::SHA1.hexdigest(hash_key).to_i(16)
  end
  
  def hash_key
    str = ""

    for i in (0...@floors.count) do
      str << i.to_s
      str << @floors[i].map(&:to_s).sort.join
    end
    str << @elevator_level.to_s

    str
  end

  def to_s
    hash_key
  end

  def inspect
    to_s
  end
end
