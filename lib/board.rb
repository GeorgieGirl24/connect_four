require_relative 'cell'
require 'tty-table'
require 'colorized_string'
require 'colorize'
class Integer
  Alph = ("a".."z").to_a
  def alph
    s, q = "", self
    (q, r = (q - 1).divmod(26)); s.prepend(Alph[r]) until q.zero?
    s
  end
end

class Board
  ALPHABET = {
              1 => 'A', 2 => "B", 3 =>"C", 4 => "D", 5 => "E", 6 => "F",
              7 => "G", 8 => "H", 9 => "I", 10 => "J", 11 => "K", 12 => "L",
              13 => "M", 14 => "N", 15 => "O", 16 => "P", 17 => "Q", 18 => "R",
              19 => "S", 20 => "T", 21 => "U", 22 => "V", 23 => "W", 24 => "X",
              25 => "Y", 26 => "Z"
            }
  attr_reader :height, :width
  attr_accessor :cells

  def initialize(height=6, width=7)
    @height = height
    @width = width
    @cells = []
  end

  def render_board
    create_header
    cells.map do |cell|
      if cell.coordinates.chars[0] == alphabet_range.max
        print cell.render.on_yellow
        puts
      elsif cell.coordinates.chars[0] == alphabet_range.min
        print " " + cell.render.on_yellow
      else
        print cell.render.on_yellow
      end
    end
    create_header
  end

  def create_header
    puts " " + alphabet_range.join.red
  end

  def create_board
    ALPHABET.keys[0..@height - 1].map do |number|
      alphabet_range.map do |letter|
         cell = Cell.new(nil, letter + number.to_s)
         @cells << cell
      end
    end
  end

  def alphabet_range
    ALPHABET.values[0..@width - 1]
  end

  def colorize_range(header)
      require 'pry';binding.pry
  end

  def update_cell(column, type)
    find_largest_empty_cell_in_column(column).type = type
  end

  def find_largest_empty_cell_in_column(column)
    find_all_empty_cells_in_column(column).max_by do |cell|
      cell.coordinates.chars[1]
    end
  end

  def find_all_cells_in_column(column)
    @cells.find_all do |cell|
      cell.coordinates.chars[0] == column
    end
  end

  def find_all_empty_cells_in_column(column)
    find_all_cells_in_column(column).find_all do |cell|
      cell.occupied? == false
    end
  end

  def find_all_empty_cells
    @cells.find_all do |cell|
      cell.occupied? == false
    end
  end

  def group_by_column
    @cells.group_by do  |cell|
      cell.coordinates.chars[0]
    end
  end

  def group_by_row
    @cells.group_by do  |cell|
      cell.coordinates.chars[1]
    end
  end

  def ord_numbers_by_row
    group_by_row.map do |row_number, rows|
      rows.map do |cell|
        cell.coordinates[0].ord
      end
    end
  end

  def group_ord_number_by_row
    ord_numbers_by_row[0].each_cons(4).to_a
  end

  def ord_numbers_by_column
    group_by_column.map do |column_letter, columns|
      columns.map do |cell|
        cell.coordinates[1].to_i
      end
    end
  end

  def group_ord_number_by_column
    ord_numbers_by_column[0].each_cons(4).to_a
  end

  # def find_all_right_diagonal_cells(cell)
  #   require 'pry';binding.pry
  # end

  def group_by_right_diagonal(col_idx, col_height=4)
    # this will be an array filled with coordinates or nil
    diagonal_group = []

    if col_idx[1].to_i == @height
      (col_idx[0].ord..(col_idx[0].ord + @height)).each_with_index do |col, height|
        diagonal_group << col.chr + (col_idx[1].to_i - height).to_s
      end

      letters = diagonal_group.map { |coordinates| coordinates[0] }
      numbers = diagonal_group.map { |coordinates| coordinates[1].to_i }

      all_possible_coor_diagonal = diagonal_group.select do |coordinate|
        alphabet_range.include?(coordinate[0]) && coordinate[1].to_i > 0
      end
    else
      far_from_baseline = 6 - col_idx[1].to_i
      temp_col_idx = col_idx
      counter = far_from_baseline

      far_from_baseline.times do
        temp_down_left = (temp_col_idx[0].ord - counter).chr + (temp_col_idx[1].to_i + counter).to_s
        diagonal_group << temp_down_left
        counter -= 1
      end
      diagonal_group << col_idx

      (col_idx[0].ord..alphabet_range.last.ord).each_with_index do |col, height|
        diagonal_group << col.chr + ( col_idx[1].to_i - height ).to_s
      end

      all_possible_coor_diagonal = diagonal_group.uniq.select do |coordinate|
          (alphabet_range.include?(coordinate[0])) && (coordinate[1].to_i > 0) && (coordinate[1].to_i <= @height)
      end
    end
  end

  def group_by_left_diagonal(col_idx, col_height=4)
    # this will be an array filled with coordinates or nil
    diagonal_group = []

    if col_idx[1].to_i == @height
       (col_idx[0].ord..(col_idx[0].ord + @height)).each_with_index do |col, height|
         diagonal_group << (col_idx[0].ord - height).chr + ((col_idx[1].to_i - height).to_s)
       end

       letters = diagonal_group.map { |coordinates| coordinates[0] }
       numbers = diagonal_group.map { |coordinates| coordinates[1].to_i }

       all_possible_coor_diagonal = diagonal_group.select do |coordinate|
         alphabet_range.include?(coordinate[0]) && coordinate[1].to_i > 0
       end.reverse
    else
      far_from_baseline = col_idx[1].to_i
      temp_col_idx = col_idx
      counter = far_from_baseline

      far_from_baseline.times do
        temp_up_left = (temp_col_idx[0].ord - counter).chr + (temp_col_idx[1].to_i - counter).to_s
        diagonal_group << temp_up_left
        counter -= 1
      end
      diagonal_group << col_idx

      (col_idx[0].ord..alphabet_range.last.ord).each_with_index do |col, height|
        diagonal_group << (col_idx[0].ord + height).chr + ( col_idx[1].to_i + height ).to_s
      end

      all_possible_coor_diagonal = diagonal_group.uniq.select do |coordinate|
          (alphabet_range.include?(coordinate[0])) && (coordinate[1].to_i > 0) && (coordinate[1].to_i <= @height)
      end
    end
  end
end
