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
    @heap.compact.empty?
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

    # return if parent less than child
    return if @heap[parent_index] <= @heap[index]
    
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
    child_index += 1 if not_last && right_child < left_child

    # return if already larger than child
    return if @heap[index] <= @heap[child_index]

    swap(index, child_index)

    heapify_down(child_index)
  end

  def swap(source, target)
    @heap[source], @heap[target] = @heap[target], @heap[source]
  end
end
