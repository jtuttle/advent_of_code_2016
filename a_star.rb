class PriorityQueue
  def initialize
    @heap = [nil]
  end

  def <<(item)
    @heap << item
    heapify_up(@heap.size - 1)
  end

  def pop
    swap(1, @heap.size - 1)
    max = @heap.pop
    heapify_down(1)
    max
  end

  def empty?
    @heap.empty?
  end

  def size
    @heap.compact.size
  end

  def print
    puts @heap.join(', ')
  end

  private

  def heapify_up(index)
    # return if we reach root
    return if index <= 1

    parent_index = (index / 2)

    # return if parent greater than child
    return if @heap[parent_index] >= @heap[index]
    
    swap(index, parent_index)
    heapify_up(parent_index)
  end

  def heapify_down(index)
    child_index = index * 2

    # return if we reach bottom of tree
    return if child_index > @heap.size - 1

    not_last = child_index < @heap.size - 1
    left_child = @heap[child_index]
    right_child = @heap[child_index + 1]
    child_index += 1 if not_last && right_child > left_child

    # return if already larger than child
    return if @heap[index] >= @heap[child_index]

    swap(index, child_index)

    heapify_down(child_index)
  end

  def swap(source, target)
    @heap[source], @heap[target] = @heap[target], @heap[source]
  end
end

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

        if neighbor.x == 34 && neighbor.y == 42
          puts "34, 42 prio: #{neighbor_priority}"
        end

        if neighbor.x == 35 && neighbor.y == 43
          puts "35, 43 prio: #{neighbor_priority}"
        end

          frontier << Node.new(neighbor, neighbor_priority)
          origin_map[neighbor] = current.data
        end
      end
    end

    path = []
    item = @goal

    while !item.nil?
      path << item
      item = origin_map[item]
    end      

    path.reverse
  end
end
