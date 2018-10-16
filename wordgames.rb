# ******************************************************************************
# Create a program which takes string input from the user and then
# prints it reversed
# ******************************************************************************

# Deliberately not used the builtin reverse method
# reverse method1: split string into array & then pop last value into new array
def reverse_string_one
  reversed = []
  puts 'Please enter string to reverse'
  string = gets.chomp.split('')
  string.length.times { reversed.push(string.pop) }
  puts reversed.join('')
end

# reverse method2: iterate over string & add each char at beginning of new var
def reverse_string_two
  reversed_string = ''
  i = 0
  puts 'Please enter string to reverse'
  string = gets.chomp
  while i < string.length
    reversed_string = string[i] + reversed_string
    i += 1
  end
  puts reversed_string
end

# ******************************************************************************
# Modify your program so that it scrambles the word randomly (turning it into an
# anagram) scrambles the word without use of the shuffle method
# ******************************************************************************

def make_anagram
  puts 'Please enter word'
  string = gets.chomp.split('')
  string.length.times do |i|
    # first line of loop ensures that i and j are never the same
    j = i + rand(string.length - 1)
    string[i], string[j] = string[j], string[i]
  end
  puts string.join('')
end

# ******************************************************************************
# Now try things the other way around - ask the user for an anagram which the
# program will try to solve. To start with, print a list of 5 words and ask
# the user to scramble one of them.
# ******************************************************************************

# anagram guesser - subroutine logic to find anagram = sort alphabetically
def anagram_guess
  loop do
    puts 'Please provide an anagram of one of the following:'
    words = %w[book vehicle phone laptop ruby]
    puts words
    user_anagram = gets.chomp
    words.each do |word|
      if word.length != user_anagram.length
        puts "#{user_anagram} is not an anagram of #{word}"
      elsif word == user_anagram
        puts "#{user_anagram} is not an anagram of #{word}"
      elsif word.each_char.sort.join('') == user_anagram.each_char.sort.join('')
        puts "#{user_anagram} is an anagram of #{word}"
      end
    end
    puts 'Play again? (y/n)'
    response = gets.chomp
    response == 'y' ? next : break
  end
end

# ******************************************************************************
# Wrap the code which performs these tests in a class, so that when you are
# given an anagram, you create an instance of Anagram (or however you have
# named it), then call methods or properties on this to test candidates words
# to see if they match
# ******************************************************************************

# class representing an anagram solver object
class AnagramSolver
  ##
  # params/attrs:
  # words = list of words file
  # anagrams = anagrams found
  ##
  attr_accessor :words

  def initialize(words)
    @words = File.read(words).downcase.chomp.lines.to_a
    @anagrams = []
  end

  # start game
  def play
    puts 'Please provide an anagram'
    user_input = gets.chomp
    find_anagrams(user_input, @words)
  end

  # first two conditions are special cases
  def find_anagrams(userinput, wordlist)
    wordlist.each do |word|
      if userinput.length != word.length
        puts "#{userinput} is not an anagram of #{word}"
      elsif userinput == word
        puts "#{userinput} is not an anagram of #{word}"
      elsif userinput.each_char.sort.join('') == word.each_char.sort.join('')
        puts "#{userinput} is an anagram of #{word}!"
        @anagrams.push(word)
      end
    end
    puts "Found #{@anagrams.length} anagram(s)..."
  end
end

newgame = AnagramSolver.new('wordlist.txt')
newgame.play
