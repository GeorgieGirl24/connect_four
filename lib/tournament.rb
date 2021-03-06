require_relative 'messages'
require_relative 'game'
class Tournament
  include Messages
  attr_reader :total_games_played,
              :total_games_won_by_player,
              :total_games_won_by_computer,
              :game,
              :games

  def initialize
    @total_games_played = 0
    @total_games_won_by_player = 0
    @total_games_won_by_computer = 0
    @games = []
  end

  def welcome_tournament
    welcome_message
    level_choice
    user_level = gets.chomp.upcase
    analyze_game(user_level)
  end

  def first_game
    @game.board.create_board
    @game.welcome
    # game.board.render_board
    @game.start_game
  end

  def analyze_game(level)
    if level == 'B' || level == 'BEGINNER'
      @game = Game.new(self)
      @games << @game
      @game.board.create_board
      @game.board.render_board
      @game.start_game
    elsif level == 'I' || level == 'INTERMEDIATE'
      @game = Game.new(self, 2)
      @games << @game
      @game.board.create_board
      @game.board.render_board
      @game.start_game
    elsif  level == 'A' || level == 'ADVANCED'
      @game = Game.new(self, 3)
      @games << @game
      @game.board.create_board
      @game.board.render_board
      @game.start_game
    end
  end

  def add_winner(winner, win_manner)
    @total_games_played += 1
    if @total_games_played == 1
      if winner == 'player'
        @total_games_won_by_player += 1
      else
        @total_games_won_by_computer += 1
      end
      the_first_win(win_manner, winner)
    elsif player_winner?(winner)
      if first_player_win?
        player_wins_first(win_manner, @total_games_won_by_player, @total_games_played)
      else
        player_wins_again(win_manner, @total_games_won_by_player, @total_games_played)
      end
    elsif computer_winner?(winner)
      if first_computer_win?
        computer_wins_first(win_manner, @total_games_won_by_computer,@total_games_played)
      else
        computer_wins_again(win_manner, @total_games_won_by_computer,@total_games_played)
      end
    end
  end

  def player_winner?(winner)
    if winner == 'player'
      @total_games_won_by_player += 1
    end
  end

  def computer_winner?(winner)
    if winner == 'computer'
      @total_games_won_by_computer += 1
    end
  end

  def first_player_win?
    @total_games_won_by_player == 1
  end

  def first_computer_win?
    @total_games_won_by_computer == 1
  end
end
