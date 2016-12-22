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

def cached_hash_get(index, hash, &block)
  if hash.has_key?(index)
    hash[index]
  else
    new_value = yield(index)
    hash[index] = new_value
    new_value
  end
end

def find_last_key_index(salt, key_target)
  index = 0
  key_count = 0
  last_key_index = 0

  hash_map = {}
  quintuplet_map = {}

  while key_count < key_target
    hash = cached_hash_get(index, hash_map) { |index| yield(salt, index) }
      
    first_triplet = hash[TRIPLET_REGEX]

    unless first_triplet.nil?
      for i in (index + 1..index + 1000)
        quintuplet_chars = cached_hash_get(i, quintuplet_map) do |j|
          cached_hash_get(j, hash_map) { |index| yield(salt, index) }.
            scan(QUINTUPLET_REGEX).map { |m| m[0] }
        end
        
        if quintuplet_chars.include?(first_triplet[0])
          #puts "match #{index} (#{first_triplet[0]}) with #{i} (#{future_hash})"
          key_count += 1
          last_key_index = index
          break
        end
      end
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
