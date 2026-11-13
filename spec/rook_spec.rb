# frozen_string_literal: true

require_relative '../lib/pieces/rook'

describe Rook do
  describe '#valid_move?' do
    let(:rook) { Rook.new(:white) }

    it 'return true for valid moves' do
      expect(rook.valid_move?([4, 3], [3, 3])).to be true
      expect(rook.valid_move?([4, 3], [4, 4])).to be true
      expect(rook.valid_move?([4, 3], [4, 2])).to be true
      expect(rook.valid_move?([4, 3], [5, 3])).to be true
    end

    it 'return false for invalid moves' do
      expect(rook.valid_move?([4, 3], [3, 4])).to be false
      expect(rook.valid_move?([4, 3], [2, 5])).to be false
    end
  end
end
