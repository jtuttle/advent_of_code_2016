input = File.open("day_4_input.txt").readlines

def letter_count(name)
  freqs = Hash.new(0)
  top = 0

  name.each_char do |char|
    next if char == '-'
    freqs[char] += 1
  end

  freqs
end

def get_sector(line)
  line.split('-')[-1][/.+?(?=\[)/].to_i
end

def get_name(line)
  line.split('-')[0..-2].join('-')
end

def is_real_room?(line)
  split_line = line.split('-')
  name = get_name(line)
  possible_checksum = split_line[-1][/(?<=\[)(.*)(?=\])/]  
  
  freqs = letter_count(name)
  sorted_freqs = freqs.sort_by { |letter, count| [-count, letter] }

  checksum = sorted_freqs.map { |i| i[0] }.join[0...5]

  checksum == possible_checksum
end

def decrypt(name, sector, alphabet)
  decrypted = ""

  name.each_char do |char|
    if char == "-"
      decrypted << char
      next
    end

    idx = alphabet.find_index(char)
    decrypted << alphabet[(idx + sector) % 26]
  end

  decrypted
end

sector_sum = 0

input.each do |line|
  sector = get_sector(line)

  sector_sum += sector if is_real_room?(line)
  
  decrypted_name = decrypt(get_name(line), sector, "abcdefghijklmnopqrstuvwxyz".split(//))

  if decrypted_name[/north/]
    puts "Sector for #{decrypted_name}: #{sector}"
  end
end

puts "Sector sum: #{sector_sum}"
