input = '347312-805915'

range_start, range_end = input.split('-')

passwords = []

(range_start..range_end).each do |num|
  same     = false
  increase = true

  num.chars.each_with_index do |digit, index|
    same     = true  if !index.zero? && digit == num[index - 1]
    increase = false if !index.zero? && digit < num[index - 1]
  end

  passwords << num if same && increase
end

print passwords.count
