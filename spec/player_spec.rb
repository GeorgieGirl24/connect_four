require './board'
require './player'
require './game'
require './computer'
require './messages'

RSpec.describe Player do
  it 'exists' do
    game = Game.new
    player = game.player
    expect(player).to be_an_instance_of Player
  end

  it 'has attributes' do
    game = Game.new
    player = game.player
    expect(player.name).to eq "Player"
    expect(player.alphabet_range).to eq game.board.alphabet_range
    expect(player.column_choice).to eq ""
  end

  it 'can place a piece in the desired column' do
    game = Game.new
    game.board.create_board
    player = game.player
    computer = game.computer

    expect(game.valid_option("A")).to eq true

    game.board.update_cell("A", 'player')
    game.board.update_cell("A", 'computer')
    game.board.update_cell("A", 'player')
    game.board.update_cell("A", 'computer')
    game.board.update_cell("A", 'player')
    game.board.update_cell("A", 'player')

    allow(player.column_selection).returns("D") 
    # allow(player.column_selection).to receive(:column).and_return("D")
    expect(game.valid_option("A")).to eq false
    expect(player.column_choice).to_not eq "A"
    # require 'pry';binding.pry
    expect(player.column_choice).to_not eq ""
    player.column_selection

    expect(game.valid_option(player.column_choice)).to eq true
    expect(player.column_choice).to eq "D"

    #     paint_1 = double("paint")
    # allow(paint_1).to receive(:color).and_return('Van Dyke Brown')
  end

  it 'can' do
    game = Game.new
    player = game.player
    computer = game.computer
  end
 end
