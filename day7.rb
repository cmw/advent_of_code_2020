require_relative 'advent_data'

data = AdventData.new(day: 7).get

class Bag
  @@index = {}
  attr_accessor :contents, :parents, :name

  def initialize(name)
    @contents = {}
    @parents = []
    @name = name
    @@index.merge!({name => self})
  end

  def add_contents(content, count)
    bag = Bag.find_or_new(content)
    bag.parents << self
    @contents.merge!({bag => count.to_i})
  end

  def ancestors
    ancs = parents.map(&:ancestors)
    [parents, ancs].flatten.uniq
  end

  def nested_count
    @contents.map {|bag, count| (1 + bag.nested_count) * count }.sum
  end

  def self.find_or_new(name)
    find(name) || new(name)
  end

  def self.find(name)
    @@index[name]
  end

  def self.all
    @@index
  end
end

data.each do |line|
    # plaid tomato bags contain 1 posh brown bag, 3 muted white bags, 4 vibrant fuchsia bags, 2 drab magenta bags.
    bag, contents = line.split('contain')
    bag = Bag.find_or_new(bag.strip.chomp(' bags'))

    contents = contents.chomp('.').split(', ')
    contents.map! { |c| c.chomp('s').chomp(' bag').match(/(\d+)\s(.+)/)[1..2].reverse rescue nil }
    contents.compact.each { |c| bag.add_contents(*c) }
end

# puts Bag.all
puts Bag.find('shiny gold').ancestors.count
puts Bag.find('shiny gold').nested_count