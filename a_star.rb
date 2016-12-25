require_relative 'priority_queue'
require_relative 'node'

class AStar
  def initialize(start, goal, neighbor_proc, heuristic_proc, goal_proc)
    @start = start
    @goal = goal
    @neighbor_proc = neighbor_proc
    @heuristic_proc = heuristic_proc
    @goal_proc = goal_proc
  end

  def execute
    frontier = PriorityQueue.new
    frontier << Node.new(@start, 0)

    origin_map = { @start => nil }
    cost_map = { @start => 0 }

    while !frontier.empty?
      current = frontier.pop

      if @goal_proc.call(current.data, @goal)
        @goal = current.data
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
