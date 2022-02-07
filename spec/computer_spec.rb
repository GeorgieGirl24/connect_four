require './board'
require './game'
require './player'
require './computer'
require './turn'
require './computer'
RSpec.describe Computer do
  it 'exists' do
    alphabet_range = ["A", "B", "C", "D", "E", "F", "G"]
    computer = Computer.new(alphabet_range)
    expect(computer).to be_an_instance_of Computer
  end

  it 'has attributes' do
    alphabet_range = ["A", "B", "C", "D", "E", "F", "G"]
    computer = Computer.new(alphabet_range)
    expect(computer.level).to eq 1
  end

  it 'can randomly choose a column inside the games range' do
    game = Game.new
    computer = Computer.new(game.board.alphabet_range)

    expect(computer.column_selection).to be_a String
    expect(computer.column_selection).to_not eq "K"
    expect(computer.column_selection).to_not eq "Z"
    expect(computer.column_selection).to_not eq "H"
  end

  it 'can choose another column if the whole column is full' do
    game = Game.new
    computer = Computer.new(game.board.alphabet_range)
    player = Player.new

    game.board.update_cell("A", player)
    game.board.update_cell("A", computer)
    game.board.update_cell("A", player)
    game.board.update_cell("A", computer)
    game.board.update_cell("A", player)
    game.board.update_cell("A", player)

    expect(game.valid_option("A")).to eq false
    expect(computer.column_selection).to_not eq "A"
  end
end
