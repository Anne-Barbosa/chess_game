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
    it "places the black rook at [0, 0]" do
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

  describe "full board setup" do
    let(:board) { Board.new }

    it "places black pieces in the correct back row order (row 0)" do
      expected_pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

      expected_pieces.each_with_index do |piece_class, col|
        piece = board.piece_at([0, col])
        expect(piece).to be_a(piece_class)
        expect(piece.color).to eq(:black)
      end
    end

    it "places white pieces in the correct back row order (row 7)" do
      expected_pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

      expected_pieces.each_with_index do |piece_class, col|
        piece = board.piece_at([7, col])
        expect(piece).to be_a(piece_class)
        expect(piece.color).to eq(:white)
      end
    end

    it "leaves the middle rows (2 to 5) empty" do
      (2..5).each do |row|
        (0..7).each do |col|
          expect(board.piece_at([row, col])).to eq(' ')
        end
      end
    end
  end

  describe "#algebraic_to_coords" do
    it "converts 'a8' notation to matrix indices [0, 0]" do
      board = Board.new
  
      expect(board.algebraic_to_coords("a8")).to eq([0, 0])
    end

    it "converts 'e2' notation to matrix indices [6, 4]" do
      board = Board.new

      expect(board.algebraic_to_coords("e2")).to eq([6, 4])
    end
  end

  describe "#algebraic_to_coords edge cases" do
    let(:board) { Board.new }

    it "returns nil for strings with invalid format or length" do
      expect(board.algebraic_to_coords("invalid")).to be_nil
      expect(board.algebraic_to_coords("a")).to be_nil
      expect(board.algebraic_to_coords("")).to be_nil
      expect(board.algebraic_to_coords(nil)).to be_nil
    end

    it "returns nil for coordinates outside the 8x8 board limits" do
      expect(board.algebraic_to_coords("z9")).to be_nil
      expect(board.algebraic_to_coords("i4")).to be_nil
      expect(board.algebraic_to_coords("e9")).to be_nil
    end
  end
end
