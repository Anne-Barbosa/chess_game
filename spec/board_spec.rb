# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/pieces/rook'
require_relative '../lib/pieces/pawn'

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

  describe "path_clear?" do
    let(:board) { Board.new }

    it "returns false when there is a piece blocking the path in a straight line" do
      rook = Rook.new(:white)
      blocking_pawn = Pawn.new(:white)

      board.place_piece([0, 0], rook)
      board.place_piece([0, 2], blocking_pawn)
      
      expect(board.path_clear?([0, 0], [0, 4])).to be false
    end

    it "returns true when the path is completely clear" do
      board = Board.new
      (0..7).each { |c| board.grid[0][c] = nil }

      rook = Rook.new(:white)
      board.place_piece([0, 0], rook)

      expect(board.path_clear?([0, 0], [0, 3])).to be true
    end

    it "returns false when there is an obstacle in a vertical path" do
      board = Board.new
      (0..7).each { |r| board.grid[r][3] = nil }

      rook = Rook.new(:white)
      pawn = Pawn.new(:white)

      board.place_piece([1, 3], rook)
      board.place_piece([3, 3], pawn)

      expect(board.path_clear?([1, 3], [5, 3])).to be false
    end

    it "returns true when a diagonal path is completely clear" do
      board = Board.new
      board.grid = Array.new(8) { Array.new(8, nil) }

      bishop = Bishop.new(:white)
      board.place_piece([2, 2], bishop)

      expect(board.path_clear?([2, 2], [5, 5])).to be true
    end

    it "returns false when there is an obstacle in a diagonal path" do
      board = Board.new
      board.grid = Array.new(8) { Array.new(8, nil) }

      bishop = Bishop.new(:white)
      pawn = Pawn.new(:white)

      board.place_piece([2, 2], bishop)
      board.place_piece([4, 4], pawn) 

      expect(board.path_clear?([2, 2], [5, 5])).to be false
    end

    it "returns true for a Knight even if there are pieces in between (because it jumps)" do
      board = Board.new
      board.grid = Array.new(8) { Array.new(8, nil) }

      knight = Knight.new(:white)
      blocking_pawn = Pawn.new(:white)

      board.place_piece([4, 4], knight)
      board.place_piece([3, 4], blocking_pawn) 

      expect(board.path_clear?([4, 4], [2, 5])).to be true
    end
  end

  describe "valid_destination?" do
    let(:board) { Board.new }

    it "returns true when the destination square is empty" do
      white_rook = Rook.new(:white)
      expect(board.valid_destination?([4, 4], white_rook)).to be true
    end

    it "returns false when the destination square has a friendly piece" do
      board.grid = Array.new(8) { Array.new(8, nil) }

      white_rook = Rook.new(:white)
      friendly_pawn = Pawn.new(:white)

      board.place_piece([4, 4], friendly_pawn)

      expect(board.valid_destination?([4, 4], white_rook)).to be false
    end

    it "returns true when the destination square has an enemy piece (capture)" do
      board.grid = Array.new(8) { Array.new(8, nil) }

      white_rook = Rook.new(:white)
      enemy_pawn = Pawn.new(:black)

      board.place_piece([4, 4], enemy_pawn)

      expect(board.valid_destination?([4, 4], white_rook)).to be true
    end
  end

  describe "move" do
    let(:board) { Board.new }

    it "successfully moves a piece when all validations pass" do 
      board.grid = Array.new(8) { Array.new(8, nil) }
      rook = Rook.new(:white)
      board.place_piece([4, 4], rook)

      result = board.move([4, 4], [4, 7])

      expect(result). to be true
      expect(board.piece_at([4, 4,])).to be_nil
      expect(board.piece_at([4, 7])).to be(rook)
    end

    it "fails to move when the path is blocked" do
      board.grid = Array.new(8) { Array.new(8, nil) }
      rook = Rook.new(:white)
      pawn = Pawn.new(:white)

      board.place_piece([4, 4], rook)
      board.place_piece([4, 6], pawn)

      result = board.move([4, 4], [4, 7])

      expect(result).to be false
      expect(board.piece_at([4, 4])).to eq(rook)
    end
  end

  describe "in_check?" do
    it "returns true when the white king is under attack by a black rook" do
      board = Board.new
      
      board.grid.map! { |row| row.fill(" ") }

      board.grid[4][4] = King.new(:white)
      board.grid[4][0] = Rook.new(:black)

      expect(board.in_check?(:white)).to be true
    end

    it "returns false when the white king is not under attack" do
      board = Board.new

      board.grid.map! { |row| row.fill(" ") }

      board.grid[4][4] = King.new(:white)

      expect(board.in_check?(:white)).to be false
    end
  end
end
