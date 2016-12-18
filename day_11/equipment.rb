class Equipment
  attr_reader :element, :type

  def initialize(element, type)
    @element = element
    @type = type
  end

  def inspect
    to_s
  end
  
  def to_s
    "#{element[0].capitalize}#{element[1]}#{type.to_s[0].capitalize}"
  end
end
