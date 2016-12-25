class Node
  include Comparable

  attr_reader :data, :value

  def initialize(data, value)
    @data = data
    @value = value
  end

  def <=>(other)
    if self.value < other.value
      -1
    elsif self.value > other.value
      1
    else
      0
    end
  end

  def to_s
    @data.to_s
  end
end
