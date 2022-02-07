require "colorize"
class Cell
  attr_accessor :type
  attr_reader :coordinates
  def initialize(type=nil, coordinates="")
    @type = type
    @coordinates = coordinates
  end

  def render
    if @type == 'computer'
      'O'.blue
    elsif @type == 'player'
      'X'.magenta
    else
      '.'.white
    end
  end

  def occupied?
    !@type.nil?
  end

  def place_piece(type)
    @type = type
  end
end
