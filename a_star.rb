require_relative 'priority_queue'

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

class AStar
  def initialize(start, goal, neighbor_proc, heuristic_proc)
    @start = start
    @goal = goal
    @neighbor_proc = neighbor_proc
    @heuristic_proc = heuristic_proc
  end

  def execute
    frontier = PriorityQueue.new
    frontier << Node.new(@start, 0)

    origin_map = { @start => nil }
    cost_map = { @start => 0 }

    while !frontier.empty?
      current = frontier.pop

      if current.data == @goal
        break
      end

      for neighbor in @neighbor_proc.call(current.data)
        neighbor_cost = cost_map[current.data] + 1

        if !cost_map.has_key?(neighbor) || neighbor_cost < cost_map[neighbor]
          cost_map[neighbor] = neighbor_cost
          neighbor_priority = neighbor_cost + @heuristic_proc.call(neighbor, @goal)
          frontier << Node.new(neighbor, neighbor_priority)
          origin_map[neighbor] = current.data
        end
      end
    end

    return nil if !origin_map.has_key?(@goal)

    path = []
    item = @goal

    while !item.nil?
      path << item
      item = origin_map[item]
    end      

    path.reverse
  end
end
