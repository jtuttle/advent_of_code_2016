require 'digest'
require_relative 'a_star'

input = "mmsxrhfx"

Struct.new("Point", :x, :y)

UP = 0; DOWN = 1; LEFT = 2; RIGHT = 3;

class PuzzleState
  attr_reader :position, :path

  def initialize(position, path)
    @position = position
    @path = path
  end

  def ==(other)
    self.position == other.position && self.path == other.path
  end
    
  def hash
    Digest::SHA1.hexdigest("#{@position.x},#{@position.y},#{path}").to_i(16)
  end
  
  def inspect
    "#{@position.x},#{@position.y},#{path}"
  end

  def to_s
    "#{@position.x},#{@position.y},#{path}"
  end

  alias_method :eql?, :==
end

def is_open?(char)
  char.to_i(16) > 10
end

def get_next_puzzle_states(input, current_state)
  valid_states = []

  hash = Digest::MD5.hexdigest("#{input}#{current_state.path}")
  current_pos = current_state.position

  if current_state.position.y > 0 && is_open?(hash[UP])
    next_pos = Struct::Point.new(current_pos.x, current_pos.y - 1)
    valid_states << PuzzleState.new(next_pos, "#{current_state.path}U")
  end

  if current_state.position.y < 3 && is_open?(hash[DOWN])
    next_pos = Struct::Point.new(current_pos.x, current_pos.y + 1)
    valid_states << PuzzleState.new(next_pos, "#{current_state.path}D")
  end

  if current_state.position.x > 0 && is_open?(hash[LEFT])
    next_pos = Struct::Point.new(current_pos.x - 1, current_pos.y)
    valid_states << PuzzleState.new(next_pos, "#{current_state.path}L")
  end

  if current_state.position.x < 3 && is_open?(hash[RIGHT])
    next_pos = Struct::Point.new(current_pos.x + 1, current_pos.y)
    valid_states << PuzzleState.new(next_pos, "#{current_state.path}R")
  end

  valid_states
end

def manhattan_distance(p1, p2)
  (p1.x - p2.x).abs + (p1.y - p2.y).abs
end

start_state = PuzzleState.new(Struct::Point.new(0, 0), "")
goal_state = PuzzleState.new(Struct::Point.new(3, 3), "")

neighbor_proc = Proc.new { |current| get_next_puzzle_states(input, current) }
heuristic_proc = Proc.new { |current, goal| manhattan_distance(current.position, goal.position) }
goal_proc = Proc.new { |current, goal| current.position == goal.position }

search = AStar.new(start_state, goal_state, neighbor_proc, heuristic_proc, goal_proc)
path = search.execute

if path.nil?
  puts "No valid path found."
else
  puts "Path to goal is: #{path.last.path}"
end
