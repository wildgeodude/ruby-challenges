# build RPS

# base class representing a player
class Player
  ##
  # params/attrs:
  # score = player's scoregame
  # choice = player's RPS play
  ##
  attr_accessor :score
  attr_accessor :choice

  def initialize
    @score = 0
    @choice = nil
  end

  # method to update score + 1
  def update_score
    @score += 1
  end
end

class UserPlayer < Player
  ##
  # child class
  # params/attrs:
  # name = player name
  ##
  attr_accessor :name

  def initialize(name)
    super()
    @name = name
  end

  # method assigns choice to @choice attribute
  def choose
    user_input = 0
    until %w[rock paper scissors].include?(user_input)
      puts 'Choose rock, paper or scissors'
      user_input = gets.chomp
    end
    @choice = user_input
  end
end

class ComputerPlayer < Player
  ##
  # child class
  # params/attrs:
  # name = computer name
  ##
  attr_accessor :name

  def initialize
    super()
    @name = 'Computer'
  end

  # method randomly chooses rps values
  def choose
    @choice = %w[rock paper scissors].sample
  end

  # intelligence + method1: male propensity to choose rock = weight paper
  def paper_choose
    weights = [0.3, 0.4, 0.3]
    choices = %w[rock paper scissors]
    loaded_choices = choices.zip(weights).to_h
    # lambda that randomly returns a key from y in proportion to its weight
    # references max weight from hash & then uses it as part of lambda for rand
    loaded_choices.max_by { |_, weight| rand**(1.0 / weight) }.first
  end

  # intelligence + method2: tendency of players to pick the whatever play
  # would have beaten them on their last loss on their next go
  def prev_choose(hash, lastwinner)
    computer_choice = if @choice != 0 && lastwinner == 'player'
                        hash.dig(@choice.to_sym).key('lose')
                      else
                        choose
                      end
    computer_choice
  end
end

# class representing game logic & scoring
class Game
  def initialize
    @scoring_hash = {
      rock: { rock: 'draw', paper: 'lose', scissors: 'win' },
      paper: { rock: 'win', paper: 'draw', scissors: 'lose' },
      scissors: { rock: 'lose', paper: 'win', scissors: 'draw' }
    }
    @player1 = nil
    @player2 = nil
    @lastwinner = nil
    @best_of_tally = 3
    @round = 1
  end

  # method to init player classes
  def create_players
    puts 'What is your name?'
    username = gets.chomp
    @player1 = UserPlayer.new(username)
    @player2 = ComputerPlayer.new
  end

  # main play method - starting no. of rounds = 3 when init
  def play(number)
    number.times do
      userchoice = @player1.choose
      # computerchoice = @player2.choose
      # computerchoice = @player2.paper_choose
      computerchoice = @player2.prev_choose(@scoring_hash, @lastwinner)
      scoregame(userchoice, computerchoice)
    end
    puts "Scores are #{@player1.score} to #{@player1.name} and " \
    "#{@player2.score} to #{@player2.name}"
    bestof
  end

  # method updates scoring based on choices using hash attribute
  def scoregame(userchoice, computerchoice)
    puts "Player guessed #{userchoice} and Computer guessed #{computerchoice}"
    case @scoring_hash.dig(userchoice.to_sym, computerchoice.to_sym)
    when 'win'
      puts "#{@player1.name} is the winner"
      @player1.update_score
      @lastwinner = 'player'
    when 'lose'
      puts "#{@player2.name} is the winner"
      @player2.update_score
      @lastwinner = 'computer'
    when 'draw'
      puts 'Nobody won...'
    end
    puts "End of round #{@round}"
    @round += 1
  end

  # method to extend play if the human player loses (best of 5, 7 etc . . .)
  def bestof
    while @player1.score < @player2.score
      puts "Best of #{@best_of_tally + 2} (y/n)?"
      user_response = gets.chomp
      user_response == 'y' ? (@best_of_tally += 2; play(2)) : (puts 'Thanks for playing')
      break
    end
  end
end

newgame = Game.new
newgame.create_players
newgame.play(3)
