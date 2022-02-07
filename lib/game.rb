require 'colorize'
require_relative 'board'
require_relative 'player'
require_relative 'computer'
require_relative 'messages'
require_relative 'turn'
require_relative 'tournament'

class Game
  include Messages
  attr_reader :board,
              :player,
              :computer,
              :messages,
              :player_places,
              :computer_places,
              :win_type,
              :winner,
              :tournament

  def initialize(tournament, level=1)
    @tournament = tournament
    @board = analyze_board(level)
    @player = Player.new(@board.alphabet_range)
    @computer = Computer.new(@board.alphabet_range, level)
    @player_places = []
    @computer_places = []
    @win_type
    @winner = ''
  end

  def analyze_board(level)
    if level == 1
      Board.new
    elsif level == 2
      Board.new(8, 9)
    elsif level == 3
      Board.new(10, 11)
    end
  end

  def welcome
    puts
    # welcome_message
    @board.render_board
  end

  def start_game
    game_flow
  end

  def game_flow
    while !@board.find_all_empty_cells.nil? do
      turn = Turn.new(@player, @computer, @board)
      turn.full_board?
      turn.prompt_player_to_choose
      if !turn.valid_placement?(player.column_choice)
        prompt_player_choose_again(player.column_choice)
        game_flow
      end

      player_column = player.column_choice
      turn.player_places << @board.find_largest_empty_cell_in_column(player_column)
      turn.place_player_piece(player_column)

      evaluate_competitor_turn(turn, 'player')

      computer_column = turn.find_computer_column(turn.computer_choice)
      turn.computer_places << @board.find_largest_empty_cell_in_column(computer_column)
      turn.place_computer_piece(computer_column)

      evaluate_competitor_turn(turn, 'computer')

      @board.render_board
      player_confirmation(@player.column_choice)
    end
  end

  def evaluate_competitor_turn(turn, type)
    if turn.evaluate_tie(turn)
      end_game('', true)
    end

    if turn.evaluate_vertical(type) ||
      turn.evaluate_horizontal(type) ||
      turn.evaluate_right_diagonal(type) ||
      turn.evaluate_left_diagonal(type)
      assign_win_type(turn.win_type)
      assign_winner(type)
      end_game(type)
    end
  end

  def assign_win_type(win_manner)
    @win_type = win_manner
  end

  def assign_winner(winner)
    @winner = winner
  end

  def end_game(type, tie=false)
    @board.render_board
    if tie == true
      there_is_a_tie
      reply = gets.chomp.upcase
      restart?(reply)
    elsif type == 'player'
      player_wins(@win_type)
      reply = gets.chomp.upcase
      restart?(reply)
    else
      computer_wins(@win_type)
      reply = gets.chomp.upcase
      restart?(reply)
    end
  end

  def restart
    level_choice
    user_level = gets.chomp.upcase
    @tournament.analyze_game(user_level)
  end

  def restart?(reply)
    if reply[0] == 'Y'
      @tournament.add_winner(@winner, @win_type)
      restart
    elsif reply[0] == 'N' || reply == 'QUIT' || reply[0] == 'Q'
      quit_the_game
    end
  end

  def quit_the_game
    puts 'Goodbye!'
    exit(true)
  end
end
