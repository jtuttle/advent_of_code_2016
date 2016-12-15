require 'digest'

#input = "abc"
input = "yjdafjpo"

TRIPLET_REGEX = /(.)\1{2}/
QUINTUPLET_REGEX = /(.)\1{4}/

def generate_hash(salt, index, repetitions = 0)
  hash = Digest::MD5.hexdigest(salt + index.to_s)

  repetitions.times do
    hash = Digest::MD5.hexdigest(hash)
  end

  hash
end

def find_last_key_index(salt, key_target)
  index = 0
  key_count = 0
  last_key_index = 0

  triplet_map = {}

  while key_count < key_target
    hash = yield(salt, index)

    quintuplet_chars = hash.scan(QUINTUPLET_REGEX).map { |m| m[0] }

    quintuplet_chars.each do |qc|
      triplet_map.keys.select { |k| k > index - 1000 }.each do |k|
        if triplet_map[k] == qc
          puts "match #{k} (#{triplet_map[k]}) with #{index} (#{hash})"

          key_count += 1
          last_key_index = k
          break if key_count == key_target
        end
      end
    end

    first_triplet = hash[TRIPLET_REGEX]

    unless first_triplet.nil?
      triplet_map[index] = first_triplet[0]
    end

    index += 1
  end

  last_key_index
end

key_target = 64

rehash_count = 0
last_index = find_last_key_index(input, key_target) { |salt, index| generate_hash(salt, index, rehash_count) }
puts "Key #{key_target} was produced from index #{last_index} using #{rehash_count} rehashes."

rehash_count = 2016
last_index = find_last_key_index(input, key_target) { |salt, index| generate_hash(salt, index, rehash_count) }
puts "Key #{key_target} was produced from index #{last_index} using #{rehash_count} rehashes."
