require "colorize"
# require 'colorized_string'
module Messages
  def welcome_message
    puts
    puts 'Welcome to Connect Four!'+ " " + 'In this game, you will be matched up against me, the Computer of your nightmares, for a battle of whits.'
    puts 'Your moves will be marked with an' + ' X'.magenta + ' and mine will be marked with an ' +  'O'.blue + '.'
    puts 'The first one to get four of our markers in a row will win! These four pieces can be lined up horizontally, verticaly or diagonally for a win!'
    puts 'If there is no winner, the game will be called a draw when the whole board is filled with our pieces.'
    puts "Good luck! You'll need it, as I am a fierce competitor!"
    puts
  end

  def level_choice
    puts 'You have your choice of how hard this game will be!'
    puts 'A' + '(b)eginner'.blue + ' level will mean you need to get four markers in a row. The board will be 6 x 7.'
    puts 'A' + '(i)ntermediate'.yellow + ' level will mean you need to get five markers in a row. The board will be 8 x 9.'
    puts 'A' + '(a)dvanced'.red + ' level will mean you need to get six markers in a row. The board will be 10 x 11.'
    puts 'Please indicate which level you would like to choose.'
    print '>'
  end

  def player_choose_first_column(alphabet_range)
    # require 'pry';binding.pry
    puts 'Please select a column to drop your piece on the board!'
    puts "Your choices are from #{alphabet_range.min} to #{alphabet_range.max}"
    print "<"
    gets.chomp.upcase
  end

  def player_column_choice
    puts
    puts 'Which column would you like to select next?'
    print "<"
    # gets.chomp.upcase
  end

  def player_confirmation(column)
    puts "Column" + " #{column}" + ", great choice!"
  end

  def prompt_player_choose_again(column)
    puts "Column" + " #{column}" + ", is not a valid choice. Please try again!"
    # p "That is not a valid choice. Please try again!"
  end

  def player_wins(win_manner)
    puts "🎉 You have bested me, with a #{win_manner} win! 🎉"
    puts 'I would like to be given another chance. Wanna play again?'
    print '>[Yes/No]'
  end

  def computer_wins(win_manner)
    puts "💻 I have bested you, with a #{win_manner} win! 💻"
    puts 'I will give you another chance. Wanna play again?'
    print '>[Yes/No]'
  end

  def there_is_a_tie
    puts '💥 We tied! 💥'
    puts 'Would you want to play again?'
    print '>[Yes/No]'
  end

  def the_first_win(win_manner, winner)
    puts
    if winner == 'player'
      puts 'You won the first game!'
    elsif winner == 'computer'
      puts 'I won the first game!'
    end

    puts "This will hopefully be the first game of many! Thanks for playing again!"
    puts
  end

  def player_wins_first(win_manner, player_wins, total_games)
    puts
    puts "Thanks for playing again! You won with a #{win_manner} win."
    puts "We have played #{total_games} games and this is your first win."
    puts
    puts "I will work harder and beat you this time!"
    puts
  end

  def player_wins_again(win_manner, player_wins, total_games)
    puts
    puts "Thanks for playing again! You won with a #{win_manner} win."
    puts "We have played #{total_games} games and you have won #{player_wins}."
    puts "I will work harder and beat you this time!"
    puts
  end

  def computer_wins_first(win_manner, computer_wins, total_games)
    puts
    puts "Thanks for playing again! I beat you with a #{win_manner} win."
    puts "We have played #{total_games} games and this is my first win"
    puts "You will need to work harder to bet me this time!"
    puts
  end

  def computer_wins_again(win_manner, computer_wins, total_games)
    puts
    puts "Thanks for playing again! I beat you with a #{win_manner} win."
    puts "We have played #{total_games} games and I have won #{player_wins}."
    puts "You will need to work harder to bet me this time!"
    puts
  end
end
