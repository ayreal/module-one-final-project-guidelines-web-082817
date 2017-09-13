require_relative '../config/environment'
require_relative '../db/migrate/001_create_dancers.rb'
require "pry"

game = Game.new
game.welcome

# Dancer.create_dancer
