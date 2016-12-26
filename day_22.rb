input = File.open("day_22_input.txt").readlines[2..-1]

class Node
  attr_accessor :x, :y, :used, :avail
    
  def initialize(x, y, size, used, avail)
    @x = x
    @y = y
    @size = size
    @used = used
    @avail = avail
  end
  
  def to_s
    "#{@x},#{@y}"
  end

  def inspect
    to_s
  end
end

def read_nodes(input)
  nodes = []

  input.each do |line|
    line_split = line.split

    x = line_split[0].split('-')[1][1..-1].to_i
    y = line_split[0].split('-')[2][1..-1].to_i
    size = line_split[1][0...-1].to_i
    used = line_split[2][0...-1].to_i
    avail = line_split[3][0...-1].to_i

    nodes << Node.new(x, y, size, used, avail)
  end

  nodes
end

def find_viable_pairs(nodes)
  viable_pairs = []

  for i in (0...nodes.length)
    for j in (i+1...nodes.length)
      if (nodes[i].used > 0 && nodes[i].used <= nodes[j].avail) ||
          (nodes[j].used > 0 && nodes[j].used <= nodes[i].avail)
        viable_pairs << [nodes[i], nodes[j]]
      end
    end
  end

  viable_pairs
end


nodes = read_nodes(input)
viable_pairs = find_viable_pairs(nodes)

puts "There are #{viable_pairs.count} viable pairs."
