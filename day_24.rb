require 'digest'

input = File.open("day_24_input.txt").readlines

class Tile
  attr_accessor :x, :y, :open

  def initialize(x, y, open)
    @x = x
    @y = y
    @open = open
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
    "#{@x},#{@y}"
  end

  def to_s
    "#{@x},#{@y}"
  end

  def inspect
    to_s
  end
end

def read_tiles(input)
  tile_map = {}
  target_map = {}

  for y in (0...input.count)
    row = input[y].strip
    
    for x in (0...row.length)
      char = row[x]
      open = (char != "#")
      
      tile = Tile.new(x, y, open)

      if ![".", "#"].include?(char)
        target_map[char] = tile
      end
      
      tile_map[tile.hash_key] = tile
    end
  end

  return tile_map, target_map
end

def get_neighbors(tile, tile_map)
  neighbors = []

  [1, -1].each do |i|
    x_key = "#{tile.x + i},#{tile.y}"
    neighbor = tile_map[x_key]
    neighbors << neighbor if neighbor.open

    y_key = "#{tile.x},#{tile.y + i}"
    neighbor = tile_map[y_key]
    neighbors << neighbor if neighbor.open
  end

  neighbors
end

def manhattan_distance(p1, p2)
  (p1.x - p2.x).abs + (p1.y - p2.y).abs
end

tile_map, target_map = read_tiles(input)

neighbor_proc = Proc.new { |tile| get_neighbors(tile, tile_map) }
heuristic_proc = Proc.new { |p1, p2| manhattan_distance(p1, p2) }
goal_proc = Proc.new { |p1,p2| p1 == p2 }

#AStar search = AStar.new(
