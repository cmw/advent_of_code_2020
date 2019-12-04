input = '347312-805915'

range_start, range_end = input.split('-')

passwords = []

(range_start..range_end).each do |num|
  long_digit = 0
  same       = false
  increase   = true

  num.chars.each_with_index do |digit, index|
    long_digit = digit if digit == num[index + 1].to_i.to_s && digit == num[index + 2].to_i.to_s
    same       = true  if !index.zero? && digit == num[index - 1] && digit != long_digit
    increase   = false if !index.zero? && digit < num[index - 1]
  end

  passwords << num if same && increase
end

print passwords.count
