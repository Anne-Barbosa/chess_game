# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path('../lib', __dir__))

require_relative '../lib/game'

def start_game
  system('clear') || system('cls')
  puts "========================================"
  puts "       CHESS GAME IN RUBY (TDD)         "
  puts "========================================"
  puts "1. Start New Game"
  puts "2. Load Saved Game"
  print "\nChoose an option (1 or 2): "

  choice = gets.chomp.strip

  game = case choice
         when '2'
           Game.load_game || start_new_game_fallback
         else
           start_new_game
         end

  game.play
end

def start_new_game
  board = Board.new
  board.setup_board
  Game.new(board, :white)
end

def start_new_game_fallback
  puts "\nStarting a new game instead..."
  sleep(1.5)
  start_new_game
end

start_game