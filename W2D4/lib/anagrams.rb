def first_anagram?(first_str, second_str)
  perms = first_str.chars.permutation.to_a
  perms.include?(second_str.chars)
end

def second_anagram?(first_str, second_str)
  x = first_str.chars
  x.each do |letter|
    index = second_str.chars.index(letter)
    return false if index.nil?
    second_str.chars.delete_at(index)
    first_str.chars.delete_at(index)
  end
  true
end

def third_anagram?(first_str, second_str)
  first_str.chars.sort == second_str.chars.sort
end

def fourth_anagram?(first_str, second_str)
  hash1 = Hash.new(0)
  hash2 = Hash.new(0)
  first_str.chars.each do |let|
    hash1[let] += 1
  end
  second_str.chars.each do |let|
    hash2[let] += 1
  end
  hash1 == hash2
end
