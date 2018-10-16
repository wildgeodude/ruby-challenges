# ******************************************************************************
# Create a program which outputs the 2 times table ( 1 x 2 = 2, 2 x 2 = 4, etc)
# ******************************************************************************

# first
(1..12).each { |number| puts "#{number} * 2 = #{number * 2}" }

# second
number = 1
while number <= 12
  puts "#{number} * 2 = #{number * 2}"
  number += 1
end

# ******************************************************************************
# Amend program so that it asks for a number and outputs table (e.g. 2, 3, etc)
# ******************************************************************************

puts 'Please input a number'
choice = gets.to_i
(1..12).each do |n|
  puts "#{n} * #{choice} = #{n * choice}"
end

# ******************************************************************************
# Amend program so that if -1 given above, it outputs all tables from 1 to 12
# ******************************************************************************

puts 'Please input a number'
choice = gets.chomp.to_i
numbers = (1..12)
numbers.each do |k|
  if choice == -1
    numbers.each { |i| puts "#{i} * #{k} = #{i * k}" }
  else
    puts "#{k} * #{choice} = #{k * choice}"
  end
end

# ******************************************************************************
# Create a class which generates a Times Table and use to produce the output
# ******************************************************************************

##
# Class representing a timestable output
class TimestableObj
  ##
  # params/attrs:
  # choice = times table to generate
  # numbers = multiplier for table
  def initialize(choice)
    @choice = choice
    @numbers = *(1..12)
  end

  def generate_table
    @numbers.each do |num|
      puts "#{num} * #{@choice} = #{num * @choice}"
    end
  end
end

testobject = TimestableObj.new(5)
testobject.generate_table
