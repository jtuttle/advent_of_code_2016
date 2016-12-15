input = File.open("day_15_input.txt").readlines

Struct.new("Disc", :positions, :current)

def init_discs(input)
  discs = []

  for i in (0...input.size) do
    split_line = input[i].split

    positions = split_line[3].to_i
    current = split_line[-1][0...-1].to_i
    disc = Struct::Disc.new(positions, current)

    discs << disc
  end

  discs
end

def compute_goal(discs)
  goal = []

  for i in (0...discs.size) do
    disc = discs[i]
    goal << (disc.positions - (i + 1)) % disc.positions
  end

  goal
end

def time_to_goal(discs, goal)
  time = 0

  while discs.map { |d| d.current } != goal do
    discs.each { |d| d.current = (d.current + 1) % d.positions }
    time += 1
  end

  time
end

discs = init_discs(input)
goal = compute_goal(discs)
puts "Part one goal reached at time #{time_to_goal(discs, goal)}"

discs = init_discs(input)
discs << Struct::Disc.new(11, 0)
goal = compute_goal(discs)
puts "Part two goal reached at time #{time_to_goal(discs, goal)}"
