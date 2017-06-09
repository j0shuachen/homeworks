def bad_two_sum?(arr, target)
  counter1 = 0
  while counter1 < arr.length-1
    counter2 = counter1 + 1
    while counter2 < arr.length-1
      return [counter1, counter2] if arr[counter1] + arr[counter2] == target
      counter2+=1
    end
    counter1+=1
  end
end   #n^2

def okay_two_sum?(arr, target)
  arr = arr.sort

  arr.each do |num|
    second_num = target - num
    if arr.bsearch { |x| second_num <=> x }
      return true
    end
  end
  false
end #nlogn

def two_sum_linear(arr, target)

  my_hash = Hash.new

  arr.each do |el|
    my_hash[el] = true
  end

  my_hash.keys.each do |num1|
    num2 = target - num1
    return true if my_hash[num2]
  end
  false
end #n
