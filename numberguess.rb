# ******************************************************************************
# Write a program which picks a random number between 1 and 100. Ask the user to
# guess the number. Tell them when they get it right (and then exit)
# Instead of exiting, ask the user if they would like to play again
# Give the user a hint - Higher! or Lower! depending on how close their
# guess was
# If the user is close (within 5 or 10 - you decide), then give them more help
# - Almost! But Lower!, etc
# Keep track of the number of guesses the user has to make and tell them how
# many it took at the end
# Track how long (in seconds or minutes) it takes the user to guess correctly
# and let them know when they get it right
# Allow the user to set the upper and lower limits when they start the game
# (wrap logic in a class, so that you pass these values in when starting up)
# Write the same program, but the other way around! Make a program which will
# try to guess a number you are thinking of. Make it react to feedback such as
# lower, higher, etc!
# ******************************************************************************

# class representing number game - tracking time taken to guess correctly
class NumberGame
  ##
  # params/attrs:
  # lower = the lower bound for game
  # upper = the upper bound for game
  # randnum = pseudo-random-number generated using bounds
  ##
  def initialize(lower, upper)
    @lower = lower
    @upper = upper
    @randnum = rand(@lower..@upper)
  end

  def play
    guesses = 0
    t1 = Time.now
    loop do
      puts 'Guess what number I am thinking of...'
      guess = gets.chomp.to_i
      guesses += 1
      rangechecker(guess)
      break if guess == @randnum
    end
    t2 = Time.now
    puts "Game has ended - it took you #{guesses} guesses", "in #{t2 - t1}"\
     'seconds'
  end

  # method checks user guess & helps them along . . .
  def rangechecker(guess)
    if guess.between?(@randnum + 1, @randnum + 5)
      puts 'Slightly lower!'
    elsif guess.between?(@randnum - 5, @randnum - 1)
      puts 'Slightly higher!'
    elsif guess > @randnum
      puts 'Lower'
    elsif guess < @randnum
      puts 'Higher'
    elsif guess == @randnum
      puts 'You got it!'
    end
  end

end

# testobj = NumberGame.new(1, 100)
# testobj.play

# ******************************************************************************
# Write the same program, but the other way around!
# Make a program which will try to guess a number you are thinking of.
# Make it react to feedback such as lower, higher, etc!
# ******************************************************************************

# class representing number guessing game but computer guesses
class NumberGameFeedback
  ##
  # params/attrs:
  # lower = the lower bound for the game
  # upper = the upper bound for the game
  ##
  def initialize(lower, upper)
    @lower = lower
    @upper = upper
  end

  def announce_bounds
    puts "The lower bound is #{@lower} and the upper bound is #{@upper}"
  end

  # recursive method that changes u/l bounds based on computer guess
  def recursive_guess(low, high, turns = 1)
    computer_guess = rand(low..high)
    puts "Is it #{computer_guess}?"
    response = gets.chomp
    case response
    when 'higher'
      recursive_guess(computer_guess + 1, high, turns + 1)
    when 'lower'
      recursive_guess(low, computer_guess - 1, turns + 1)
    when 'correct'
      puts "Found the correct number in #{turns} turns"
    end
  end

  def play
    announce_bounds
    recursive_guess(@lower, @upper)
  end
end

game = NumberGameFeedback.new(1, 100)
game.play
