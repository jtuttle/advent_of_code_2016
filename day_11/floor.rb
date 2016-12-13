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
