require_relative 'advent_data'

data = AdventData.new(day: 14).get

@memory = {}
@memory_v2 = {}
@address_mask = @value_mask = nil

def mask(line)
  bits = line.split(' = ').last.strip.split('').reverse
  @address_mask = bits.map.with_index{ |bit, idx| [idx, bit] }
  @value_mask = @address_mask.reject{|idx, bit| bit == 'X' }
end

def mem(line)
  address, value = line.split(' = ')
  @memory[address] = mask_value(value.to_i)
end

def mem_v2(line)
  address, value = line.split(' = ')
  addresses = mask_address(address)
  addresses.each do |addr|
    @memory_v2[addr] = value.to_i
  end
end

def mask_value(value)
  bits = number_to_36_bits(value.to_i)
  @value_mask.each do |idx, bit|
    bits[idx] = bit
  end
  bits_to_number(bits)
end

def mask_address(address)
  address_number = address.match(/mem\[(\d+)\]/)[1]
  address_bits = number_to_36_bits(address_number.to_i)
  possible_addresses = [address_bits]

  @address_mask.each do |idx, bit|
    case bit
    when 1, '1'
      possible_addresses.each { |addr| addr[idx] = 1 }
    when 'X'
      new_addresses = []
      possible_addresses.each do |addr|
        addr[idx] = 0
        new_addresses << addr.dup
        addr[idx] = 1
      end
      possible_addresses += new_addresses
    end
  end

  possible_addresses.map{ |x| bits_to_number(x) }
end

def number_to_36_bits(number)
  number.to_s(2).rjust(36, '0').split('').reverse
end

def bits_to_number(bits)
  bits.reverse.join('').to_i(2)
end

data.each do |line|
  case line
  when /^mask/
    mask(line)
  when /^mem/
    mem(line)
    mem_v2(line)
  end
end


puts @memory.values.sum
puts @memory_v2.values.sum
