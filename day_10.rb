input = File.open("day_10_input.txt").readlines

@node_index = {}

class Node
  attr_accessor :name, :low_receiver, :high_receiver, :chips, :history

  def initialize(name)
    @name = name
    @chips = []
    @history = []
  end

  def give_chip(value)
    chips.delete(value)
  end

  def take_chip(value)
    chips << value
    history << value
  end

  def is_full?
    name.split[0] == "bot" && @chips.count == 2
  end
end

def get_node(name)
  return @node_index[name] if @node_index.include?(name)
  
  new_node = Node.new(name)
  @node_index[name] = new_node

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

def transfer_chip(from, to, value)
  from.give_chip(value)
  to.take_chip(value)
end

def simulate
  full = @node_index.select { |k,v| v.is_full? }.values.to_a

  while full.count > 0
    giver = full.pop

    transfer_chip(giver, giver.low_receiver, giver.chips.min)
    full << giver.low_receiver if giver.low_receiver.is_full?

    transfer_chip(giver, giver.high_receiver, giver.chips.max)
    full << giver.high_receiver if giver.high_receiver.is_full?
  end
end

def find_comparer(val1, val2)
  @node_index.find { |k,v| v.history.sort == [val1, val2].sort }.first
end

build_graph(input)
simulate

val1 = 61
val2 = 17

puts "#{val1} and #{val2} were compared by #{find_comparer(val1, val2)}"

outputs = [0, 1, 2]
output_product = outputs.map { |i| @node_index["output #{i}"].chips.first }.reduce(:*)

puts "The product of chips in outputs #{outputs.join(', ')} is #{output_product}"
