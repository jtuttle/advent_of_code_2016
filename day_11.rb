Dir['./day_11/*.rb'].each{ |f| require f }

input = File.open("day_11_input.txt").readlines

def try_move(building, equipment, from_elevator_level, to_elevator_level)
  return nil if ![1,2].include?(equipment.count) || 
    to_elevator_level < 0 || to_elevator_level > building.floors.count

  clone = building.clone
  clone.move_equipment(equipment, from_elevator_level, to_elevator_level)
  clone.valid? ? clone : nil
end

def generate_valid_moves(building)
  valid_building_states = []

  elevator_level = building.elevator_level
  current_floor = building.current_floor

  for i in (0...current_floor.count)
    # move up
    building_state = try_move(building, [current_floor[i]], elevator_level, elevator_level + 1)
    valid_building_states << building_state unless building_state.nil?

    # move down
    building_state = try_move(building, [current_floor[i]], elevator_level, elevator_level - 1)
    valid_building_states << building_state unless building_state.nil?

    for j in (i+1...current_floor.count)
      # move up
      building_state = try_move(building, [current_floor[i], current_floor[j]], elevator_level, elevator_level + 1)
      valid_building_states << building_state unless building_state.nil?

      # move down
      building_state = try_move(building, [current_floor[i], current_floor[j]], elevator_level, elevator_level - 1)
      valid_building_states << building_state unless building_state.nil?
    end
  end
  
  valid_building_states
end

def distance_from_goal(building)
  distance = 0

  floor_count = building.floors.count

  for i in (0...floor_count) do
    building.floors[i].each do |e|
      distance += floor_count - i - 1
    end
  end

  distance
end

def is_goal_state?(building)
  distance_from_goal(building) == 0
end


bldg = Building.new
bldg.parse(input)
bldg.print
puts distance_from_goal(bldg)

valid = generate_valid_moves(bldg)

valid.each do |bldg|
  puts "*****"
  bldg.print
  puts distance_from_goal(bldg)
end
