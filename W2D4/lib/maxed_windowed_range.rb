def naive(arr, w)
  counter = 1
  largest_diff = arr[0...w].max - arr[0...w].min
  while counter < arr.length-w
    temp = arr[counter...counter+w].max - arr[counter...counter+w].min
    largest_diff = temp if temp > largest_diff
    counter+=1
  end
  largest_diff
end
