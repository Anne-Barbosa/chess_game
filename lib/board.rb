# frozen_string_literal: true

require_relative 'pieces/piece'
require_relative 'pieces/rook'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/queen'
require_relative 'pieces/king'
require_relative 'pieces/pawn'

class Board
  attr_accessor :grid

  def initialize
    @rows = 8
    @columns = 8
    @grid = Array.new(@rows) { Array.new(@columns, ' ') }
    setup_board
  end

  def setup_board
    back_row_pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

    back_row_pieces.each_with_index do |piece_class, col|
      @grid[0][col] = piece_class.new(:black)
      @grid[1][col] = Pawn.new(:black)
    end

    back_row_pieces.each_with_index do |piece_class, col|
      @grid[6][col] = Pawn.new(:white)
      @grid[7][col] = piece_class.new(:white)
    end
  end

  def piece_at(coords)
    row = coords[0]
    col = coords[1]
    @grid[row][col]
  end

  def algebraic_to_coords(notation)
    return nil unless notation.is_a?(String) && notation.length == 2

    col_char = notation[0].downcase
    row_char = notation[1]

    return nil unless ('a'..'h').include?(col_char) && ('1'..'8').include?(row_char)

    col = col_char.ord - 'a'.ord
    row = 8 - row_char.to_i

    [row, col]
  end

  def place_piece(pos, piece)
    row, col = pos
    @grid[row][col] = piece
  end

  def path_clear?(start_pos, end_pos)
    piece = piece_at(start_pos)
    return true if piece.is_a?(Knight)
    
    start_row, start_col = start_pos
    end_row, end_col = end_pos

    row_step = end_row <=> start_row
    col_step = end_col <=> start_col

    current_row = start_row + row_step
    current_col = start_col + col_step

    while [current_row, current_col] != [end_pos[0], end_pos[1]]
      cell = @grid[current_row][current_col]
      return false unless cell.nil? || cell == ' '

      current_row += row_step
      current_col += col_step
    end

    true
  end

  def display
    puts "\n    a   b   c   d   e   f   g   h"
    puts "  +---+---+---+---+---+---+---+---+"

    @grid.each_with_index do |row, index|
      row_number = 8 - index
      print "#{row_number} |"

      row.each do |cell|
        symbol = cell.is_a?(Piece) ? cell.symbol : ' '
        print " #{symbol} |"
      end

      puts " #{row_number}"
      puts "  +---+---+---+---+---+---+---+---+"
    end

    puts "    a   b   c   d   e   f   g   h\n\n"
  end
end