input = File.open("day_10_input.txt").readlines

@nodes = {}

class Node
  attr_accessor :name, :low_receiver, :high_receiver, :chips, :history

  def initialize(name)
    @name = name
    @chips = []
    @history = []
  end

  def take_chip(value)
    chips << value
    history << value
  end

  def is_full_bot?
    name.split[0] == "bot" && @chips.count == 2
  end
end

def get_node(name)
  return @nodes[name] if @nodes.include?(name)
  
  new_node = Node.new(name)
  @nodes[name] = new_node

  new_node
end

def build_graph(input)
  input.each do |line|
    split_line = line.split

    if split_line[0] == "bot"
      giver = get_node(split_line[0..1].join(' '))
      low_receiver = get_node(split_line[5..6].join(' '))
      high_receiver = get_node(split_line[10..11].join(' '))

      giver.low_receiver = low_receiver
      giver.high_receiver = high_receiver
    elsif split_line[0] == "value"
      receiver = get_node(split_line[4..5].join(' '))
      receiver.chips << split_line[1].to_i
    end
  end
end

def simulate
  full = @nodes.select { |k,v| v.is_full_bot? }.values.to_a

  while full.count > 0
    giver = full.pop

    giver.low_receiver.take_chip(giver.chips.min)
    full << giver.low_receiver if giver.low_receiver.is_full_bot?

    giver.high_receiver.take_chip(giver.chips.max)
    full << giver.high_receiver if giver.high_receiver.is_full_bot?

    giver.chips.clear
  end
end

def find_comparer(val1, val2)
  @nodes.find { |k,v| v.history.sort == [val1, val2].sort }.first
end

build_graph(input)
simulate

val1 = 61
val2 = 17

puts "The values #{val1} and #{val2} were compared by #{find_comparer(val1, val2)}"

outputs = ["output 0", "output 1", "output 2"]
output_product = outputs.map { |i| @nodes[i].chips.first }.reduce(:*)
puts "The product of chips in outputs 0, 1, and 2 is #{output_product}"
