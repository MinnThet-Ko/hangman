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



    @@quiz_string = '-' * @@quiz_word.length

  end



  def self.check_input_letter(input_letter)

    if @@quiz_word.include?(input_letter)



      index = @@quiz_word.index(input_letter)



      @@quiz_string[index] = input_letter



      puts @@quiz_string



      true



    else



      false



    end

  end

end



HangMan.load_dictionary



keep_playing = true



health = 5



while keep_playing



  puts HangMan.create_quiz_word



  while health > 0



    input_letter = gets.chomp



    health -= 1 if HangMan.check_input_letter(input_letter) == false



  end



  puts 'Will you keep playing?(Y,N)'



  answer = gets.chomp.downcase

  if answer == 'y'

    keep_playing = true

  elsif answer == 'n'

    keep_playing = false

  end

end

