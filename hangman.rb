require 'json'

# This is the main game file

class HangMan
  @@dictionary = []

  @@quiz_word = ''

  @@quiz_string = ''

  def self.load_dictionary
    File.foreach('google-10000-english-no-swears.txt') do |line|
      line = line.chomp

      @@dictionary.push(line) if line.length >= 5 && line.length <= 12
    end
  end

  def self.get_dictionary
    @@dictionary
  end

  def self.get_a_random_word
    @@dictionary[rand(@@dictionary.length - 1)]
  end

  def self.create_quiz_word
    @@quiz_word = @@dictionary[rand(@@dictionary.length - 1)]

    puts @@quiz_word

    @@quiz_string = '-' * @@quiz_word.length
  end

  def self.check_input_letter(input_letter)
    if @@quiz_word.include?(input_letter)

      quiz_word_array = @@quiz_word.split('')

      quiz_word_array.each_with_index do |letter, index|
        @@quiz_string[index] = input_letter if letter == input_letter
      end

      puts @@quiz_string

      true

    else

      false

    end
  end

  def self.is_quiz_string_full
    if @@quiz_string.include?('-')

      false

    else

      true

    end
  end
end

# class for the player

class Player
  attr_accessor :guesses

  def initialize
    @guesses = 0
  end

  def to_hash
    attribute_hash = hash
  end
end

# actual game loop

HangMan.load_dictionary

keep_playing = true

guesses = 10

while keep_playing

  player = if File.exist?('./saved_data.txt')

             File.open('./saved_data.txt') do |f|
               Marshal.load(f)
             end

           else

             Player.new

           end

  puts player.guesses

  puts JSON.pretty_generate(player.to_json)

  player.guesses += 10

  puts HangMan.create_quiz_word

  while player.guesses > 0

    input_letter = gets.chomp

    player.guesses -= 1 if HangMan.check_input_letter(input_letter) == false

    puts "You have #{player.guesses} left."

    break if HangMan.is_quiz_string_full

  end

  puts 'Will you keep playing or save and quit?(Y,N)'

  answer = gets.chomp.downcase

  if answer == 'y'

    keep_playing = true

  elsif answer == 'n'

    keep_playing = false

    File.open('./saved_data.txt', 'w+') do |f|
      Marshal.dump(player, f)
    end

  end

end
