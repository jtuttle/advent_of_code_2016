Dir['./day_11/*.rb'].each{ |f| require f }

input = File.open("day_11_input.txt").readlines

def try_move(building, equipment, from_elevator_level, to_elevator_level)
  clone = building.clone
  clone.move_equipment(equipment, from_elevator_level, to_elevator_level)
  clone.valid? ? clone : nil
end

def generate_moves(building)
  valid_buildings = []

  elevator_level = building.elevator_level
  current_floor = building.current_floor

  for i in (0...current_floor.count)
    # move up
    if elevator_level < building.floors.count
      valid_building = try_move(building, [current_floor[i]], elevator_level, elevator_level + 1)
      valid_buildings << valid_building unless valid_building.nil?
    end

    # move down
    if elevator_level > 0
      valid_building = try_move(building, [current_floor[i]], elevator_level, elevator_level - 1)
      valid_buildings << valid_building unless valid_building.nil?
    end

    for j in (i+1...current_floor.count)
      # move up
      if elevator_level < building.floors.count
        valid_building = try_move(building, [current_floor[i], current_floor[j]], elevator_level, elevator_level + 1)
        valid_buildings << valid_building unless valid_building.nil?
      end

      # move down
      if elevator_level > 0
        valid_building = try_move(building, [current_floor[i], current_floor[j]], elevator_level, elevator_level - 1)
        valid_buildings << valid_building unless valid_building.nil?
      end
    end
  end
  
  valid_buildings
end


bldg = Building.new
bldg.parse(input)
bldg.print

valid = generate_moves(bldg)

valid.each do |bldg|
  puts "*****"
  bldg.print
end
