# frozen_string_literal: true

require_relative 'piece'

class Queen < Piece
  def initialize(color)
    super(color)
    @symbol = color == :white ? "\u2655" : "\u265B"
  end
end