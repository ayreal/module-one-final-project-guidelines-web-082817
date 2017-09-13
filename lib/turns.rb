require "colorize"

class Turn < ActiveRecord::Base
  # @@songs = [/Users/Lawford/Desktop/BoxCat_Games_-_02_-_Mt_Fox_Shop.mp3,/Users/Lawford/Desktop/BoxCat_Games_-_24_-_Tricks.mp3,/Users/Lawford/Desktop/BoxCat_Games_-_21_-_Rhythm.mp3]
  # def find_player_1
  #   Dancer.all.each {|element| puts "#{element.id}. #{element.name}, #{element.hometown}, #{element.EXP}"}
  #   player_1_pick = gets.chomp.to_i
  #   Dancer.find(player_1_pick)
  # end
  #
  # def find_player_2
  #   Dancer.all.each {|element| puts "#{element.id}. #{element.name}, #{element.hometown}, #{element.EXP}"}
  #   player_2_pick = gets.chomp.to_i
  #   Dancer.find(player_2_pick)
  # end

  player1 = find_player_1
  player2 = find_player_2

  def start_match(player1,player2)
    pid = fork{ exec 'afplay', "/Users/Lawford/Desktop/BoxCat_Games_-_02_-_Mt_Fox_Shop.mp3" }
    round_count = 1
    hit_chances = [1..100]
    player_1_points = 0
    player_2_points = 0

    while round_count < 4
      # Gets dance moves from DB
      puts "Get ready for round" + " #{round_count}".bold + "!"
      puts ""
      puts ""
      sleep(2.5)
      puts "Player 1: ".red.bold + "#{player_1_points} points.".green
      puts "Pick your dance move!"
        puts "*".red*80
        DanceMove.all.each {|element| puts "#{element.id}. #{element.name}, #{element.difficulty}, #{element.point_value} pts"}
        puts "*".red*80
      player_1_move = gets.chomp.to_i
      pid = fork{ exec 'afplay', "/Users/Lawford/Desktop/Pickup_Coin53.wav" }
      puts "Player 2: ".blue.bold + "#{player_2_points} points.".green
      puts "Pick your dance move!"
        puts "*".blue*80
        DanceMove.all.each {|element| puts "#{element.id}. #{element.name}, #{element.difficulty}, #{element.point_value} pts"}
        puts "*".blue*80
      player_2_move = gets.chomp.to_i
      pid = fork{ exec 'afplay', "/Users/Lawford/Desktop/Pickup_Coin53.wav" }

      first_move = DanceMove.find(player_1_move)
      second_move = DanceMove.find(player_2_move)
      # Rolls random number to decide if move was a success
      # Awards points if move was success
      puts ""
      puts ""
      puts "Player 1".red + " is dancing!"
      sleep(2)
      if miss?(first_move)
        puts "Sorry, you blew it!"
        puts "0 points ".green + "for that weak shit!"
        pid = fork{ exec 'afplay', "/Users/Lawford/Desktop/Hit_Hurt145.wav" }
        puts ""
      else
        puts "Damn son!"
        player_1_points += first_move.point_value
        puts "#{first_move.point_value} points ".green +  "for doing #{first_move.name}!"
          pid = fork{ exec 'afplay', "/Users/Lawford/Desktop/Pickup_Coin57.wav" }
        puts ""
      end

      puts "Player 2 ".blue + "is dancing!"
      sleep(2)
      if miss?(second_move)
        puts "Sorry, you blew it!"
        puts "0 points ".green + "for that weak shit!"
        pid = fork{ exec 'afplay', "/Users/Lawford/Desktop/Hit_Hurt145.wav" }
        puts ""
        puts ""
      else
        puts "Damn son!"
        player_2_points += second_move.point_value
        puts "#{second_move.point_value} points ".green + "for doing #{second_move.name}!"
        pid = fork{ exec 'afplay', "/Users/Lawford/Desktop/Pickup_Coin57.wav" }
        puts ""
        puts ""
      end

      round_count += 1
    end

    pick_winner(player_1_points,player_2_points,player1,player2)
    #picks winner
  end

  def pick_winner(points_1,points_2,player1,player2)
    winner = ""
    #decide winner based off point totals and awards win to database
    if points_1 > points_2
      puts "Player 1 wins! Player 2 got served!".red.on_white.blink.bold
      player1.wins += 1
      player1.EXP += 10
      player2.EXP += 5
      player1.save
      player2.save
    elsif points_2 > points_1
      puts "Player 2 wins! Player 1 got served!".blue.on_white.blink.bold
      player2.wins += 1
      player2.EXP += 10
      player1.EXP += 5
      player2.save
      player1.save
    else
      puts "Its a tie!"
    end
  end


  def miss?(dance_move)
    # Checks if dance move hits or misses
    roll = rand(1..100)
    roll >= dance_move.difficulty_percentage
  end

  def give_points(player_points,dance_move)
    #award player points
    player_points += dance_move.point_value
  end

end

#
# class Turn < ActiveRecord::Base
#   belongs_to :games
#   has_many :dancers
#
#   def create_turn
#     Turn.create(dancer_id_1: dancers.id)
#   end
#
# end
#
# t.integer :dancer_id_1
# t.integer :dancer_id_2
# t.integer :dance_move_id_1
# t.integer :dance_move_id_2
# t.integer :dancer_points_1
# t.integer :dancer_points_2
