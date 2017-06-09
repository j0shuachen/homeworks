require 'byebug'

def min(array)
  array.each_with_index do |el, indx|
    found_smallest = true
    array.each_with_index do |el2, indx2|
      next if indx == indx2
      found_smallest = false if el2 < el
    end
    return el if found_smallest
  end
end


def min_iteration(array)
  min = array[0]
  array.each do |el|
    min = el if el < min
  end
  min
end

def sub_sum(array)
  return [[]] if array.empty?
  subs = sub_sum(array[0..-2])
  subs_comb = subs.map do |el|
    el + [array.last]
  end
  subs.concat(subs_comb)
end

def largest_sum(array)
  i = 0
  largest = array.first
  while i < array.length + 1
    j = i
    while j < array.length
      sum = array[i..j].reduce(:+)
      largest = sum if sum > largest
      j += 1
    end
    i += 1
  end
  largest
end

def largest_sum_n(array)
  debugger
  max_ending_here = max_so_far = array.shift
  array.each do |x|
    max_ending_here = [x, max_ending_here + x].max
    max_so_far = [max_so_far, max_ending_here].max
  end
  max_so_far
end
