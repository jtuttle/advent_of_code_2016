input = File.open("day_7_input.txt").readlines

BRACKET_REGEX = /\[.*?\]/

def supernet_seqs(line)
  line.gsub(BRACKET_REGEX, ",").split(",")
end

def hypernet_seqs(line)
  line.scan(BRACKET_REGEX).map { |s| s[1...-1] }
end

def is_abba?(str)
  str.length == 4 && str[0...2] != str[2..4] && str[0...2] == str[2..4].reverse
end

def is_aba?(str)
  str.length == 3 && str[0] != str[1] && str[0] == str[2]
end

def has_abba?(str)
  for i in (0...str.length - 3)
    return true if is_abba?(str[i...i+4])
  end

  false
end

def find_abas(str)
  abas = []

  for i in (0...str.length - 2)
    chunk = str[i...i+3]
    abas << chunk if is_aba?(chunk)
  end
  
  abas
end

def flip_aba(aba)
  raise ArgumentError if aba[0] != aba[2] || aba[0] == aba[1]

  a = aba[0]
  b = aba[1]

  "#{b}#{a}#{b}"
end

def supports_tls?(line)
  hypernet_seqs(line).each do |seq|
    return false if has_abba?(seq)
  end

  supernet_seqs(line).each do |seq|
    return true if has_abba?(seq)
  end

  false
end

def supports_ssl?(line)
  abas = []

  supernet_seqs(line).each do |seq|
    abas += find_abas(seq)
  end

  hypernet_seqs(line).each do |seq|
    abas.each do |aba|
      return true if seq.include?(flip_aba(aba))
    end
  end

  false
end

tls_count = ssl_count = 0

input.each do |line|
  tls_count += 1 if supports_tls?(line)
  ssl_count += 1 if supports_ssl?(line)
end

puts "Count of IPs that support TLS: #{tls_count}"
puts "Count of IPs that support SSL: #{ssl_count}"
