# ******************************************************************************
# Create a program which outputs random number between 1 and 6, simulating the
# roll of a die
# Make your program ask the user how many dice s/he would like to roll. Display
# the result as individual numbers (e.g. 4, 6, 2 if three dice were rolled)
# Add the total to the output above
# Create class which represents a die and re-structure your program to use this
# ******************************************************************************

##
# class representing a die with two types of roll method
class Die
  ##
  # params/attrs:
  # sides = number of sides on init
  ##
  def initialize(sides)
    @sides = sides
  end

  def roll
    puts 'How many die do you want to roll?'
    number = gets.chomp.to_i
    roll_values = []
    (1..number).each do
      roll_val = rand(1..@sides)
      puts "Roll is #{roll_val}"
      roll_values.push(roll_val)
    end
    roll_values
  end

  # method totals all rolls
  def aggregated_roll
    total = roll
    puts total.reduce(:+)
  end
end
# die = Die.new(6)
# die.aggregated_roll

# ******************************************************************************
# Create a new program, using your die class above which mimics the game
# Crown and Anchor. Ask user which area they would like to bet on & how much
# simulate the dice roll, and tell them how much they would have won (or lost)!
# ******************************************************************************

# class representing crown and anchor game
class CrownAnchor
  ##
  # attrs:
  # values_hash = each of the c&a values is assigned an int value
  # player_balance = initial amount to bet with
  # player_symbol = assigned in start_game - user's chosen value
  # player_bet = assigned in start_game - user's chosen bet
  ##
  def initialize
    @values_hash = {
      'Crown' => 1,
      'Anchor' => 2,
      'Hearts' => 3,
      'Clubs' => 4,
      'Spades' => 5,
      'Diamonds' => 6
    }
    @player_balance = 100
    @player_symbol = nil
    @player_bet = nil
  end

  # game start
  def start_game
    puts 'Please enter a symbol to bet on:'
    @player_symbol = @values_hash[gets.chomp]
    loop do
      puts 'How much do you want to gamble?'
      @player_bet = gets.chomp.to_i
      break unless @player_balance - @player_bet < 0
    end
  end

  # method simulates dice roll
  def roll_die
    die = Die.new(6)
    rolls = die.roll
    counter = rolls.count(@player_symbol)
    case counter
    when 3
      @player_balance += (@player_bet * 3)
    when 2
      @player_balance += (@player_bet * 2)
    when 1
      @player_balance += @player_bet
    else
      @player_balance -= @player_bet
    end
    puts "Player's balance is #{@player_balance}"
  end

  def play
    start_game
    roll_die
  end
end

# game = CrownAnchor.new
# game.play

# ******************************************************************************
# Create a new program, using your die class.
# Using the rules of Yahtzee, allow the user to make multiple throws of the dice
# and record their score
# ******************************************************************************

# class representing Yahtzee rolling logic - is not full representation of
# game - subclass of Die
class YahtzeeDie < Die
  ##
  # params/attrs:
  # dice_remaining = user starts with 5 dice per play
  # final_choice = final choice of roll values to be scored
  ##
  def initialize(sides)
    super(sides)
    @dice_remaining = 5
    @final_choice = []
  end

  # roll method
  def roll(number)
    roll_values = []
    (1..number).each do
      roll_val = rand(1..@sides)
      puts "Roll is #{roll_val}"
      roll_values.push(roll_val)
    end
    roll_values
  end

  # game logic for player roll choice
  def yahtzee
    count = 0
    while count < 3 && @dice_remaining > 0
      puts "You have #{@dice_remaining} dice remaining"
      player_roll = roll(@dice_remaining)
      puts 'Would you like to keep any dice?', 'Specify as "All", "None" or "(1,1,4 etc..)"'
      choice = gets.chomp
      case choice
      when 'None'
        count += 1
      when 'All'
        count += 1
        @final_choice += player_roll
        break
      else
        chosen_rolls = choice.split(',').map(&:to_i)
        puts "Your chosen rolls are #{chosen_rolls}"
        @final_choice += chosen_rolls
        @dice_remaining -= chosen_rolls.length
        count += 1
      end
    end
  end

  # prints choices which player can then score
  def print_choices
    puts "Your final choices are #{@final_choice}"
  end
end

die = YahtzeeDie.new(6)
die.yahtzee
die.print_choices
