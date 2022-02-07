require './board'
require './game'
require './player'
require './computer'
require './turn'
RSpec.describe Game do
  it 'exists' do
    game = Game.new
    expect(game).to be_an_instance_of Game
  end

  it 'has attributes' do
    game = Game.new
    expect(game.board).to be_an_instance_of Board
    expect(game.player).to be_an_instance_of Player
    expect(game.computer).to be_an_instance_of Computer
  end

  it 'can prompt the Player to choose a column' do
    game = Game.new
    board = game.board
    board.create_board
    player = game.player
    expect(game.start_game).to be_a String
    # allow(player.column_selection).
    expect(player.column_choice).not eq ""
  end

  it 'can go through a game flow' do
    game = Game.new
    player = game.player
    computer = game.computer
  end

  it 'can end a game' do
    game = Game.new
    player = game.player
    computer = game.computer
    board = game.board
  end

  
 end
