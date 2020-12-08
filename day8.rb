require_relative 'advent_data'

data = AdventData.new(day: 8).get

class TuringMachine
  class DoubleVisitException < Exception; end

  attr_reader :accumulator

  def initialize(band, fuzzy = false)
    @band = band
    @fuzzy = fuzzy
    reset
  end

  def reset(fuzzer_target = 0)
    @index = 0
    @accumulator = 0
    @fuzzer_index = 0
    @fuzzer_target = fuzzer_target
    @index_log = []
  end

  def next_element
    raise DoubleVisitException if @index_log.include? @index
    @index_log << @index
    @band[@index]
  rescue TuringMachine::DoubleVisitException
    if @fuzzy
      reset(@fuzzer_target + 1)
    else
      @index = @band.length # force termination
    end
  end

  def add(number)
    jump
    @accumulator += number
  end

  def nop
    jump
  end

  def jump(n=1)
    @index += n
  end

  def execute(line)
    return unless line.is_a?(String)
    
    op, val = line.split(' ')
    op = fuzz!(op) if @fuzzy
    case op
    when 'acc' then add val.to_i
    when 'nop' then nop
    when 'jmp' then jump val.to_i
    end
  end

  def fuzz!(op)
    return op if (op == 'acc')

    @fuzzer_index += 1
    fuzz = (@fuzzer_target == @fuzzer_index)
    return op unless fuzz

    op == 'nop' ? 'jmp' : 'nop'
  end

  def run
    until @index >= @band.count
      execute(next_element)
    end
    puts @accumulator
  end
end

tm = TuringMachine.new(data)
tm.run
fuzz_tm = TuringMachine.new(data, true)
fuzz_tm.run
