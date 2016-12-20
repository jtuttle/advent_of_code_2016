input = "01111010110010011"

def dragon(a)
  b = a.reverse.gsub(/\d/) { |bit| bit == "1" ? "0" : "1" }
  "#{a}0#{b}"
end

def expand_data(data, disk_size)
  while data.length < disk_size
    data = dragon(data)
  end

  data[0...disk_size]
end

def checksum(data)
  checksum = ""

  data.chars.each_slice(2) do |pair|
    checksum << (pair[0] == pair[1] ? "1" : "0")
  end

  checksum
end

def redo_checksum(checksum)
  while checksum.length % 2 == 0
    checksum = checksum(checksum)
  end
  
  checksum
end

disk_size = 272
data = expand_data(input, disk_size)
checksum = checksum(data)
checksum = redo_checksum(checksum)
puts "Part one checksum is #{checksum}"

disk_size = 35651584
data = expand_data(input, disk_size)
checksum = checksum(data)
checksum = redo_checksum(checksum)
puts "Part two checksum is #{checksum}"
