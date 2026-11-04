# frozen_string_literal: true

require_relative 'piece'

class Rook < Piece
  def initialize(color)
    super(color)
    @symbol = color == :white ? "\u2656" : "\u265C"
  end
end
