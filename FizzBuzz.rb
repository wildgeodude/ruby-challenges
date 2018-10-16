# build fizzbuzz

# class representing fizzbuzz game
class FizzBuzz
  ##
  # params/attrs:
  # results = array displaying results of game
  ##

  def initialize
    @results = []
  end

  def play
    puts 'Let\'s play FizzBuzz'
    puts 'Please enter max number for the game'
    user_input = gets.chomp.to_i
    (1..user_input).each do |item|
      if (item % 3).zero? && (item % 5).zero?
        @results.push('FizzBuzz')
      elsif (item % 3).zero?
        @results.push('Fizz')
      elsif (item % 5).zero?
        @results.push('Buzz')
      else
        @results.push(item)
      end
    end
    puts @results
    puts 'Game ended'
  end
end

newgame = FizzBuzz.new
newgame.play
