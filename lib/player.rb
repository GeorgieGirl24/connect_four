require_relative 'messages'
class Player
  include Messages
  attr_reader :alphabet_range, :name
  attr_accessor :column_choice
  def initialize(alphabet_range, name="Player")
    @alphabet_range = alphabet_range
    @name = name
    @column_choice = ""
  end

  def column_selection
    # require 'pry';binding.pry
    @column_choice = player_column_choice
    player_confirmation(player_column_choice)
  end
end
