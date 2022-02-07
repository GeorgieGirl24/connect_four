require 'colorize'
require_relative 'messages'
class Turn
  include Messages
  attr_reader :player,
              :computer,
              :board,
              :player_places,
              :computer_places,
              :win_type,
              :winner

  def initialize(player, computer, board)
    @player = player
    @computer = computer
    @board = board
    @player_places = []
    @computer_places = []
    @win_type = ''
    @winner = ''
  end

  def check_for_number_empty_board
    @board.find_all_empty_cells
  end

  def full_board?
    check_for_number_empty_board.empty?
  end

  def prompt_player_to_choose
    player_column_choice
    @player.column_choice = gets.chomp.upcase
    if @player.column_choice == 'QUIT'
      quit_the_game
    else
      @player.column_choice
    end
  end

  def validate_column_exists(column)
    @board.alphabet_range.include?(column)
  end

  def validate_column_is_not_full(column)
    !@board.find_largest_empty_cell_in_column(column).nil?
  end

  def valid_placement?(column)
    validate_column_is_not_full(column) && @board.alphabet_range.include?(column)
  end

  def valid_option(column)
    if !@board.find_all_empty_cells_in_column(column).empty?
      return true
    else
      return false
    end
  end

  def place_player_piece(column)
     @board.find_largest_empty_cell_in_column(column).place_piece("player")
  end

  def computer_choice
    @computer.column_selection
  end

  def place_computer_piece(column)
    @board.find_largest_empty_cell_in_column(column).place_piece("computer")
  end

  def quit_the_game
    puts 'Goodbye!'
    exit(true)
  end

  def evaluate_horizontal(type)
    occupied_rows(type)
    occupied_rows?(type)
    ords_in_a_row(type)
    element_row_count(type)

    if element_row_count(type).any? { |element| element >= find_ideal_number_consecutive }
      any_horizontal_match(type)
      assign_win_type('horizontal')
      any_horizontal_match(type).flatten.include?(true)
    else
      false
    end
  end

  def occupied_rows(type)
    @board.group_by_row.map do |key, cells|
       cells.find_all do |cell|
         cell.type == type
       end
    end
  end

  def occupied_rows?(type)
    occupied_rows(type).find_all do |rows|
      !rows.empty?
    end
  end

  def ords_in_a_row(type)
    occupied_rows?(type).map do |row|
      row.map do |cell|
        cell.coordinates[0].ord
      end
    end
  end

  def element_row_count(type)
    ords_in_a_row(type).map do |row|
      row.count
    end
  end

  def any_horizontal_match(type)
    ords_in_a_row(type).map do |row|
      if row.count > find_ideal_number_consecutive
        options = row.each_cons(find_ideal_number_consecutive).to_a
        options.map do |option|
          @board.group_ord_number_by_row.include?(option)
        end
      elsif row.count == find_ideal_number_consecutive
        @board.group_ord_number_by_row.include?(row)
      end
    end
  end

  def evaluate_vertical(type)
    occupied_columns(type)
    occupied_columns?(type)
    ords_in_a_column(type)
    element_column_count(type)

    if element_column_count(type).any? { |element| element >= find_ideal_number_consecutive }
      any_vertical_match(type)
      assign_win_type('vertical')
      any_vertical_match(type).include?(true)
    else
      false
    end
  end

  def occupied_columns(type)
    @board.group_by_column.map do |key, cells|
       cells.find_all do |cell|
         cell.type == type
       end
    end
  end

  def occupied_columns?(type)
    occupied_columns(type).find_all do |rows|
      !rows.empty?
    end
  end

  def ords_in_a_column(type)
    occupied_columns?(type).map do |column|
      column.map do |cell|
        cell.coordinates[1].to_i
      end
    end
  end

  def element_column_count(type)
    ords_in_a_column(type).map do |column|
      column.count
    end
  end

  def any_vertical_match(type)
    ords_in_a_column(type).map do |column|
      @board.group_ord_number_by_column.include?(column)
    end
  end

  def evaluate_right_diagonal(type)
    if type == 'player'
      # this is evaluating the player's pieces
      optional_right_diagonals = @board.group_by_right_diagonal(@player_places.last.coordinates)

      occupied_right_diagonals = @board.group_by_right_diagonal(@player_places.last.coordinates).map do |coordinate|
        @board.cells.find_all do |cell|
          (cell.coordinates == coordinate) && (cell.type == type)
        end
      end

      number_consecutive = coordinate_consecutive(occupied_right_diagonals)
      # number_of_occupied_right_diagonals = occupied_right_diagonals.flatten.count

      if number_consecutive
        @win_type = 'diagonal'
        assign_win_type('diagonal')
        true
      else
        false
      end

    else
      # this is evlauating the computer's pieces
      optional_right_diagonals = @board.group_by_right_diagonal(@computer_places.last.coordinates)

      occupied_right_diagonals = @board.group_by_right_diagonal(@computer_places.last.coordinates).map do |coordinate|
        @board.cells.find_all do |cell|
          (cell.coordinates == coordinate) && (cell.type == type)
        end
      end

      number_consecutive = coordinate_consecutive(occupied_right_diagonals)
      # number_of_occupied_right_diagonals = occupied_right_diagonals.flatten.count

      if number_consecutive
        @win_type = 'diagonal'
        assign_win_type('diagonal')
        true
      else
        false
      end
    end
  end

  def evaluate_left_diagonal(type)
    if type == 'player'
      # this is evaluating the player's pieces
      optional_left_diagonals = @board.group_by_left_diagonal(@player_places.last.coordinates)

      occupied_left_diagonals = @board.group_by_left_diagonal(@player_places.last.coordinates).map do |coordinate|
        @board.cells.find_all do |cell|
          (cell.coordinates == coordinate) && (cell.type == type)
        end
      end

      number_consecutive = coordinate_consecutive(occupied_left_diagonals)
      # number_of_occupied_left_diagonals = occupied_left_diagonals.flatten.count

      if number_consecutive
        @win_type = 'diagonal'
        assign_win_type('diagonal')
        true
      else
        false
      end
    else
      # this is evlauating the computer's pieces
      optional_left_diagonals = @board.group_by_left_diagonal(@computer_places.last.coordinates)

      occupied_left_diagonals = @board.group_by_left_diagonal(@computer_places.last.coordinates).map do |coordinate|
        @board.cells.find_all do |cell|
          (cell.coordinates == coordinate) && (cell.type == type)
        end
      end

      number_consecutive = coordinate_consecutive(occupied_left_diagonals)
      # number_of_occupied_left_diagonals = occupied_left_diagonals.flatten.count

      if number_consecutive
        @win_type = 'diagonal'
        assign_win_type('diagonal')
        true
      else
        false
      end
    end
  end

  def coordinate_consecutive(occupied_cells)
    # occupied_cells needs to be an array of arrays; this is checking for diagonal checks
    ord_occupied = occupied_cells.flatten.map do |cell|
      cell.coordinates[0].ord
    end
    (ord_occupied.count >= find_ideal_number_consecutive) && (ord_occupied.size - 1).times.all? { |i| ord_occupied[ i + 1 ] == ord_occupied[i] + 1 }
  end

  def evaluate_tie(turn)
    # want this to be true if the board is full
    turn.board.find_all_empty_cells.count == 0
  end

  def find_ideal_number_consecutive
    if @computer.level == 1
      4
    elsif @computer.level == 2
      5
    elsif @computer.level == 3
      6
    end
  end

  def find_computer_column(column)
    if !valid_placement?(column)
      new_column = computer_choice
      find_computer_column(new_column)
    else
      column
    end
  end

  def assign_win_type(win_manner)
    @win_type = win_manner
  end

  def assign_winner(winner)
    @winner = winner
  end
end
