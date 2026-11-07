# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  subject(:game) { Game.new }

  describe "#initialize" do
    it "starts with white as the current player turn" do
      expect(game.current_player).to eq(:white)
    end
  end

  describe "#switch_turn" do
    it "switches the turn from white to black" do
      game.switch_turn
      expect(game.current_player).to eq(:black)
    end

    it "switches the turn back from black to white" do
      game.switch_turn # vai para black
      game.switch_turn # volta para white
      expect(game.current_player).to eq(:white)
    end
  end
end
