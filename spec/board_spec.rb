# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe "#initialize" do
    it "creates an 8x8 grid with 64 total cells" do
      board = Board.new

      expect(board.grid.length).to eq(8)
      expect(board.grid).to all(have_attributes(length: 8))
      expect(board.grid.flatten.length).to eq(64)
    end
  end

  describe "#setup" do
    it "places the  black rook at [0, 0]" do
      board = Board.new
      piece = board.piece_at([0, 0])

      expect(piece).to be_a(Rook)
      expect(piece.color).to eq(:black)
    end

    it "places white pawns on the correct row" do
      board = Board.new

      board.grid[6].each do |cell|
        expect(cell).to be_a(Pawn)
        expect(cell.color).to eq(:white)
      end
    end
  end
end
