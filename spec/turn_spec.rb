require 'turn'
require 'player'
require 'computer'
require 'board'
require 'game'
RSpec.describe Turn do
  it 'exists' do
    game = Game.new
    player = game.player
    computer = game.computer
    board = game.board
    board.create_board
    turn = Turn.new(player, computer, board)
    expect(turn).to be_an_instance_of Turn
  end

  it 'has attributes' do
    game = Game.new
    player = game.player
    computer = game.computer
    board = game.board
    board.create_board
    turn = Turn.new(player, computer, board)
    expect(turn.player).to be_an_instance_of Player
    expect(turn.computer).to be_an_instance_of Computer
  end

  it 'can check if there are any empty cells' do
    game = Game.new
    player = game.player
    computer = game.computer
    board = game.board
    board.create_board
    turn = Turn.new(player, computer, board)

    expect(turn.check_for_number_empty_board).to_not eq 0
  end

  it 'can ask a player to choose a column' do
    game = Game.new
    player = game.player
    computer = game.computer
    board = game.board
    board.create_board
    turn = Turn.new(player, computer, board)

    expect(turn.prompt_player_to_choose).to be_a String
  end

  it 'can check that the players column selection is valid' do
    game = Game.new
    player = game.player
    computer = game.computer
    board = game.board
    board.create_board
    turn = Turn.new(player, computer, board)

    column = "A"
    # validate column exists
    # validate column isn't full
    expect(turn.validate_column_exists(column)).to eq true
    expect(turn.validate_column_is_not_full(column)).to eq true
    expect(turn.valid_placement?(column)).to eq true
  end

  it 'can place the players piece in the correct cell' do
    game = Game.new
    player = game.player
    computer = game.computer
    board = game.board
    board.create_board
    turn = Turn.new(player, computer, board)

    column = "A"
    turn.place_player_piece(column)
    expect(board.cells[35].coordinates).to eq "A6"
    expect(board.cells[35].type).to eq "player"
  end

  it 'can render the board after the players piece has been placed' do
    game = Game.new
    player = game.player
    computer = game.computer
    board = game.board
    board.create_board
    turn = Turn.new(player, computer, board)

    column = "A"
    turn.place_player_piece(column)
    expect(board.cells[35].coordinates).to eq "A6"
    expect(board.cells[35].type).to eq "player"

    expect(turn.board.render_board).to be_an Array
  end

  it 'can have a computer choose a random column' do
    game = Game.new
    player = game.player
    computer = game.computer
    board = game.board
    board.create_board
    turn = Turn.new(player, computer, board)

    # column = board.alphabet_range.sample

    expect(turn.computer_choice).to be_a String
  end

  it 'can check that the computers column selection is valid' do
     game = Game.new
     player = game.player
     computer = game.computer
     board = game.board
     board.create_board
     turn = Turn.new(player, computer, board)

     column = turn.computer_choice

     expect(turn.validate_column_exists(column)).to eq true
     expect(turn.validate_column_is_not_full(column)).to eq true
     expect(turn.valid_placement?(column)).to eq true
  end

  it 'can place the computers piece in the cell' do
    game = Game.new
    player = game.player
    computer = game.computer
    board = game.board
    board.create_board
    turn = Turn.new(player, computer, board)

    column = turn.computer_choice
    turn.place_computer_piece(column)
    expected = board.cells.find_index do |cell, index|
      cell.type == 'computer'
    end

    expect(board.cells[expected].coordinates.chars[0]).to eq column
    expect(board.cells[expected].type).to eq "computer"
  end

  it 'can render the board after the computers piece has been placed' do
    game = Game.new
    player = game.player
    computer = game.computer
    board = game.board
    board.create_board
    turn = Turn.new(player, computer, board)

    column = turn.computer_choice
    turn.place_computer_piece(column)
    expected = board.cells.find_index do |cell, index|
      cell.type == 'computer'
    end

    expect(board.cells[expected].coordinates.chars[0]).to eq column
    expect(board.cells[expected].type).to eq "computer"
    expect(turn.board.render_board).to be_an Array
  end

  it 'can have a player and computer have pieces on the board' do
    game = Game.new
    player = game.player
    computer = game.computer
    board = game.board
    board.create_board
    turn = Turn.new(player, computer, board)

    column = "A"
    turn.place_player_piece(column)
    expect(turn.board.render_board).to be_an Array

    column = turn.computer_choice
    turn.place_computer_piece(column)
    expected = board.cells.find_index do |cell, index|
      cell.type == 'computer'
    end

    expect(board.cells[expected].coordinates.chars[0]).to eq column
    expect(board.cells[expected].type).to eq "computer"
    expect(turn.board.render_board).to be_an Array
  end

  it 'can find evaluate a horizontal win' do
    game = Game.new
    player = game.player
    computer = game.computer
    board = game.board
    board.create_board

    turn = Turn.new(player, computer, board)
    column = "A"
    turn.place_player_piece(column)
    expect(game.evaluate_horizontal('player')).to eq false

    turn2 = Turn.new(player, computer, board)
    column = "B"
    turn2.place_player_piece(column)
    expect(game.evaluate_horizontal('player')).to eq false

    turn3 = Turn.new(player, computer, board)
    column = "C"
    turn3.place_player_piece(column)
    expect(game.evaluate_horizontal('player')).to eq false

    turn4 = Turn.new(player, computer, board)
    column = "D"
    turn4.place_player_piece(column)
    expect(game.evaluate_horizontal('player')).to eq true

    board.render_board
    expect(board.cells[35].coordinates).to eq "A6"
    expect(board.cells[35].type).to eq "player"
    expect(board.cells[36].coordinates).to eq "B6"
    expect(board.cells[36].type).to eq "player"
    expect(board.cells[37].coordinates).to eq "C6"
    expect(board.cells[37].type).to eq "player"
    expect(board.cells[38].coordinates).to eq "D6"
    expect(board.cells[38].type).to eq "player"
  end

  it 'can find evaluate a vertical win' do
    game = Game.new
    player = game.player
    computer = game.computer
    board = game.board
    board.create_board

    turn = Turn.new(player, computer, board)
    column = "A"
    turn.place_player_piece(column)
    expect(game.evaluate_vertical('player')).to eq false

    turn2 = Turn.new(player, computer, board)
    column = "A"
    turn2.place_player_piece(column)
    expect(game.evaluate_vertical('player')).to eq false

    turn3 = Turn.new(player, computer, board)
    column = "A"
    turn3.place_player_piece(column)
    expect(game.evaluate_vertical('player')).to eq false

    turn4 = Turn.new(player, computer, board)
    column = "A"
    turn4.place_player_piece(column)
    expect(game.evaluate_vertical('player')).to eq true

    board.render_board
    expect(board.cells[35].coordinates).to eq "A6"
    expect(board.cells[35].type).to eq "player"
    expect(board.cells[28].coordinates).to eq "A5"
    expect(board.cells[28].type).to eq "player"
    expect(board.cells[21].coordinates).to eq "A4"
    expect(board.cells[21].type).to eq "player"
    expect(board.cells[14].coordinates).to eq "A3"
    expect(board.cells[14].type).to eq "player"
  end

  it 'can evaluate a players win' do
    game = Game.new
    player = game.player
    computer = game.computer
    board = game.board
    board.create_board

    turn = Turn.new(player, computer, board)
    column = "A"
    turn.place_player_piece(column)

    turn2 = Turn.new(player, computer, board)
    column = "A"
    turn2.place_player_piece(column)

    turn3 = Turn.new(player, computer, board)
    column = "A"
    turn3.place_player_piece(column)

    turn4 = Turn.new(player, computer, board)
    column = "A"
    turn4.place_player_piece(column)

    board.render_board
    # expect(game.end_game('player')).to eq 'I would like to be given another chance. Wanna play again?'
    expect(game.end_game('player')).to eq nil
  end

  it 'can quit the game at anytime when you type in "quit"' do
    game = Game.new
    player = game.player
    computer = game.computer
    board = game.board
    board.create_board

    turn = Turn.new(player, computer, board)
    column = "A"
    turn.place_player_piece(column)
    turn = Turn.new(player, computer, board)
    player_choice = double('player_choice')
    turn.prompt_player_to_choose
    # order.calculate_total_price(double(:price => 1.99), double(:price => 2.99))
    # allow(player_choice).to receive(:column).and_return('Quit')
    allow(player_choice).to receive(:column).and_return('Quit')
    # require 'pry';binding.pry
  end

 end
