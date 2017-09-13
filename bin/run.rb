require_relative '../config/environment'
require_relative '../db/migrate/001_create_dancers.rb'
require "pry"

# game = Game.new
# game.welcome

DanceMove.all
turn = Turn.new
turn.start_match(Dancer.first,Dancer.second)
