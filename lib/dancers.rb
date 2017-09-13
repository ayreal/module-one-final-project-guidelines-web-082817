require_relative '../config/environment.rb'
require "pry"


class Dancer < ActiveRecord::Base
    belongs_to :turns
    has_many :dance_moves, through: :turns

    def self.create_dancer
      puts "What's your name?"
      name = gets.chomp
      puts "What's your hometown?"
      hometown = gets.chomp
      puts "Word, yo!"
      self.create(name: name, hometown: hometown, EXP: 0, wins: 0)
      game = Game.new
      game.welcome
    end
end
