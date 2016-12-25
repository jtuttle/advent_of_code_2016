input = 3014387

elves = "1" * input
current_idx = 0
next_idx = 1

while current_idx != next_idx do
  elves[next_idx] = "0"
  current_idx = next_idx
  
  for i in (current_idx + 1...current_idx + elves.length) do
    if elves[(current_idx + i) % elves.length] != "0"
      next_idx = i
      break
    end
  end
end

puts current_idx
