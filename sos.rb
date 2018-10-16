# ******************************************************************************
# Create a program which prints the Morse Code alphabet, from A to Z, using .
# and - convert your program so that it works using a range and a loop
# and a method to produce the same output (less code for the same output)
# Instead of outputting the alphabet, ask the user to input some text and then
# convert it to Morse code
# Add functionality to to convert input in Morse code back into English
# ******************************************************************************

# class representing morse code object which performs various actions
class MorseObject
  ##
  # params/attrs:
  # morse_hash = dictionary mapped values of morse code to [a-z0-9]
  ##
  def initialize
    @morse_hash = {}
  end

  # method takes file input & creates dictionary mapping of values
  def generate_morse_alphabet
    text = File.open('morsealphabet.txt').read
    text.each_line do |line|
      key, value = line.downcase.chomp.split('  ')
      @morse_hash[key] = value
    end
    @morse_hash[' '] = '/' # for spaces in sentences
  end

  # prints dictionary
  def print_alphabet
    @morse_hash.each_key { |key| puts "#{key} : #{@morse_hash[key]}" }
  end

  # maps input to dictionary
  def encode_text
    puts 'Please enter text to encode: '
    input = gets
    input.split('').each { |char| print "#{@morse_hash[char]} " }
  end

  # method decodes user input of morse code
  def decode_text
    puts 'Please enter text to decode, words separated by a fwd slash: '
    input = gets.chomp
    input.split(' ').each { |char| print @morse_hash.key(char) }
    puts "\n"
  end
end

morsetest = MorseObject.new
morsetest.generate_morse_alphabet
morsetest.print_alphabet
# morsetest.encode_text
morsetest.decode_text
