# frozen_string_literal: true

require_relative 'piece'

class Pawn < Piece
  def initialize(color)
    super(color)
    @symbol = color == :white ? "\u2659" : "\u265F"
  end
end