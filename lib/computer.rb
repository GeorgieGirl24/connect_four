class Computer
  attr_reader :alphabet_range, :level
  def initialize(alphabet_range,level=1)
    @alphabet_range = alphabet_range
    @level = level
  end

  def column_selection
    @alphabet_range.sample
  end
end
