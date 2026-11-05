# frozen_string_literal: true

require_relative '../lib/pieces/king'

describe King do
  describe "#valid_move?" do
    let(:king) { King.new(:white) }
    
    it "returns true for valid moves" do
      expect(king.valid_move?([4, 3], [4, 4])).to be true
      expect(king.valid_move?([4, 3], [5, 3])).to be true
    end

    it "returns false for invalid moves" do
      expect(king.valid_move?([4, 3], [4, 5])).to be false
      expect(king.valid_move?([4, 3], [6, 3])).to be false
    end
  end
end
