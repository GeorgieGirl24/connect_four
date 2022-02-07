require './board'
require './cell'
require './computer'
require './player'
RSpec.describe Board do
  it 'exists' do
    board = Board.new
    board.create_board
    expect(board).to be_an_instance_of Board
    board2 = Board.new(9, 10)
    expect(board2).to be_an_instance_of Board
  end

  it 'has attributes' do
    board = Board.new
    board.create_board
    expect(board.height).to be_an Integer
    expect(board.height).to eq 6
    expect(board.width).to be_an Integer
    expect(board.width).to eq 7
    expect(board.cells).to be_an Array
  end

  it 'can render an empty standard board' do
    board = Board.new
    board.create_board
    expect(board.render_board).to be_an Array
  end

  it 'can make a list of letters from the width of the board' do
    board = Board.new
    board.create_board
    expect(board.create_header).to eq "ABCDEFG"
  end

  it 'can create a board' do
    board = Board.new
    board.create_board
    # expect(board.create_board).to be_an Array
    expect(board.cells.length).to eq 42
  end

  it 'can create a standard board with 42 cells in it' do
    board = Board.new
    board.create_board
    expect(board.cells.count).to eq 42
    # expect(board.create_board).to be_an Array
    # expect(board.create_board[0]).to be_a Cell
  end

  it 'can update the appropriate cell with the Players column choice' do
    board = Board.new
    board.create_board

    column = "A"
    type = "player"
    board.update_cell(column, type)
    expect(board.cells[35].occupied?).to eq true

    expect(board.cells[35].type).to eq type
  end

  it 'can update the appropriate cell with the Computers column choice' do
    board = Board.new
    board.create_board

    column = "C"
    type = "computer"
    board.update_cell(column, type)
    expect(board.cells[37].occupied?).to eq true
    expect(board.cells[37].type).to eq type
  end

  it 'can update and know that a cell has been taken already in the column' do
    board = Board.new
    board.create_board

    player_column = "C"
    player_type = "player"
    board.update_cell(player_column, player_type)
    expect(board.cells[37].occupied?).to eq true
    expect(board.cells[37].type).to eq player_type

    computer_column = "C"
    computer_type = "computer"
    board.update_cell(computer_column, computer_type)
    expect(board.cells[30].occupied?).to eq true
    expect(board.cells[30].type).to eq computer_type
      # require "pry";binding.pry
  end

  it 'can find all the empty cells in the board' do
    board = Board.new
    board.create_board

    expect(board.find_all_empty_cells).to be_an Array
    expect(board.find_all_empty_cells.first).to be_a Cell
    expect(board.find_all_empty_cells.count).to_not eq 0
    expect(board.find_all_empty_cells.count).to eq 42
    expect(board.find_all_empty_cells.count).to eq 42
  end

  it 'can find a left diagonal' do

  end

  xit 'can find a right diagonal from a cell' do
    board = Board.new
    board.create_board

    expect(board.group_by_right_diagonal('A6')).to be_an Array
    expect(board.group_by_right_diagonal('A6').first).to be_a String
    expect(board.group_by_right_diagonal('A6').count).to eq 4
    expect(board.group_by_right_diagonal('A6')).to eq ['A6', 'B5', 'C4', 'D3']

    expect(board.group_by_right_diagonal('B6')).to be_an Array
    expect(board.group_by_right_diagonal('B6').first).to be_a String
    expect(board.group_by_right_diagonal('B6').count).to eq 4
    expect(board.group_by_right_diagonal('B6')).to eq ['B6', 'C5', 'D4', 'E3']

    expect(board.group_by_right_diagonal('C4')).to be_an Array
    expect(board.group_by_right_diagonal('C4').first).to be_a String
    expect(board.group_by_right_diagonal('C4').count).to eq 4
    expect(board.group_by_right_diagonal('C4')).to eq ['C4', 'D3', 'E2', 'F1']

    expect(board.group_by_right_diagonal('B6')).to be_an Array
    expect(board.group_by_right_diagonal('B6').first).to be_a String
    expect(board.group_by_right_diagonal('B6').count).to eq 4
    expect(board.group_by_right_diagonal('B6')).to eq ['B6', 'C5', 'D4', 'E3']

    expect(board.group_by_right_diagonal('C6')).to be_an Array
    expect(board.group_by_right_diagonal('C6').first).to be_a String
    expect(board.group_by_right_diagonal('C6').count).to eq 4
    expect(board.group_by_right_diagonal('C6')).to eq ['C6', 'D5', 'E4', 'F3']

    expect(board.group_by_right_diagonal('D6')).to be_an Array
    expect(board.group_by_right_diagonal('D6').first).to be_a String
    expect(board.group_by_right_diagonal('D6').count).to eq 4
    expect(board.group_by_right_diagonal('D6')).to eq ['D6', 'E5', 'F4', 'G3']

    expect(board.group_by_right_diagonal('E6')).to eq nil
    expect(board.group_by_right_diagonal('F6')).to eq nil
    expect(board.group_by_right_diagonal('G6')).to eq nil
    expect(board.group_by_right_diagonal('A3')).to eq nil
    expect(board.group_by_right_diagonal('B3')).to eq nil
    expect(board.group_by_right_diagonal('A1')).to eq nil
    expect(board.group_by_right_diagonal('B2')).to eq nil
    expect(board.group_by_right_diagonal('C2')).to eq nil

    # expect(board.group_by_right_diagonal('D1')).to be_an Array
    # expect(board.group_by_right_diagonal('D1').first).to be_a String
    # expect(board.group_by_right_diagonal('D1').count).to eq 4
    # expect(board.group_by_right_diagonal('D1')).to eq ['D1', 'E2', 'F3', 'G4']
  end

    it 'can find a left diagonal from a cell' do
      board = Board.new
      board.create_board

      expect(board.group_by_left_diagonal('G6')).to be_an Array
      expect(board.group_by_left_diagonal('G6').first).to be_an String
      expect(board.group_by_left_diagonal('G6').count).to eq 6
      expect(board.group_by_left_diagonal('G6')).to eq ["B1", "C2", "D3", "E4", "F5", "G6"]

      expect(board.group_by_left_diagonal('G5')).to be_an Array
      expect(board.group_by_left_diagonal('G5').first).to be_an String
      expect(board.group_by_left_diagonal('G5').count).to eq 5
      expect(board.group_by_left_diagonal('G5')).to eq ["C1", "D2", "E3", "F4", "G5"]

      expect(board.group_by_left_diagonal('G4')).to be_an Array
      expect(board.group_by_left_diagonal('G4').first).to be_an String
      expect(board.group_by_left_diagonal('G4').count).to eq 4
      expect(board.group_by_left_diagonal('G4')).to eq ["D1", "E2", "F3", "G4"]

      expect(board.group_by_left_diagonal('G3')).to be_an Array
      expect(board.group_by_left_diagonal('G3').first).to be_an String
      expect(board.group_by_left_diagonal('G3').count).to eq 3
      expect(board.group_by_left_diagonal('G3')).to eq ["E1", "F2", "G3"]

      expect(board.group_by_left_diagonal('G2')).to be_an Array
      expect(board.group_by_left_diagonal('G2').first).to be_an String
      expect(board.group_by_left_diagonal('G2').count).to eq 2
      expect(board.group_by_left_diagonal('G2')).to eq ["F1", "G2"]

      expect(board.group_by_left_diagonal('G1')).to be_an Array
      expect(board.group_by_left_diagonal('G1').first).to be_an String
      expect(board.group_by_left_diagonal('G1').count).to eq 1
      expect(board.group_by_left_diagonal('G1')).to eq ["G1"]

    end
end
