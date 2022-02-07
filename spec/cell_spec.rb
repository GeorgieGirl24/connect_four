require './cell'
RSpec.describe Cell do
  it 'exists' do
    cell = Cell.new
    expect(cell).to be_an_instance_of Cell
  end

  it 'has attributes' do
    cell = Cell.new
    # expect(cell.occupied).to eq false
    expect(cell.type).to eq nil
    expect(cell.coordinates).to be_a String
  end

  it 'can render a "." when it is unoccupied' do
    cell = Cell.new
    expect(cell.render).to eq "."
  end

  it 'can render a "X" when it is occupied by a Player' do
    # cell = Cell.new(true, 'player')
    cell = Cell.new('player')
    expect(cell.render).to eq 'X'
  end

  it 'can render a "O" when it is occupied by the Computer' do
    # cell = Cell.new(true, 'computer')
    cell = Cell.new('computer')
    expect(cell.render).to eq 'O'
  end

  it 'can tell if it is occupied' do
    # cell = Cell.new(true, 'computer')
    cell = Cell.new('computer')
    expect(cell.occupied?).to eq true
  end

  it 'can tell if it is unoccupied' do
    cell = Cell.new
    expect(cell.occupied?).to eq false
    expect(cell.occupied?).to_not eq true
  end

  it 'can tell what coordinates it is in when unoccupied' do
    # cell = Cell.new(false, nil, "A1")
    cell = Cell.new(nil, "A1")
    expect(cell.coordinates).to eq "A1"
  end

  it 'can tell what coordinates it is in when occupied' do
    # cell = Cell.new(true, 'player', "A1")
    cell = Cell.new('player', "A1")
    expect(cell.coordinates).to eq "A1"
  end

  it 'can place a piece on an empty cell' do
    cell = Cell.new
    expect(cell.occupied?).to eq false
    cell.place_piece('player')

    expect(cell.occupied?).to eq true
    expect(cell.type).to eq 'player'
  end
end
