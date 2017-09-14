require "colorize"

class Turn < ActiveRecord::Base

  @@songs = ["media/BoxCat_Games_-_02_-_Mt_Fox_Shop.mp3","media/BoxCat_Games_-_24_-_Tricks.mp3","media/BoxCat_Games_-_21_-_Rhythm.mp3"]


  def start_match(player1,player2)
    pid = fork{ exec 'afplay', @@songs.sample}
    round_count = 1
    hit_chances = [1..100]
    player_1_points = 0
    player_2_points = 0
    puts "#{player1.name}".red  + " repping #{player1.hometown}! vs."
    puts "#{player2.name}".blue + " repping #{player2.hometown}!"

    sleep(2.5)
    Catpix::print_image "media/dicso ball.png",
    :limit_x => 1.0,
    :limit_y => 0,
    :center_x => false,
    :center_y => false,
    :bg_fill => false,
    :resolution => "low"

    while round_count < 4
      # Gets dance moves from DB
      puts ""
      puts "Get ready for round" + " #{round_count}".bold + "!"
      puts "Move it, or lose it!"
      puts ""
      puts ""
      sleep(2.5)
      puts "#{player1.name}: ".red.bold + "#{player_1_points} points.".green
      puts "Pick your move!"
      puts "*".red*80
        if player1.EXP < 15
          DanceMove.all.select {|element| puts "#{element.id}. #{element.name}, #{element.difficulty}, #{element.point_value} pts" if element.difficulty == "Easy" }
          puts "*".red*80
        elsif player1.EXP >= 15 && player1.EXP < 30
          DanceMove.all.select {|element| puts "#{element.id}. #{element.name}, #{element.difficulty}, #{element.point_value} pts" if element.difficulty == "Easy" || element.difficulty == "Medium"}
          puts "*".red*80
        else player1.EXP >= 30
          DanceMove.all.select {|element| puts "#{element.id}. #{element.name}, #{element.difficulty}, #{element.point_value}"}
          puts "*".red*80
        end

        player_1_move = gets.chomp.to_i

        # until player_1_move == true
        #   if player1.EXP < 15 && player_1_move > 3
        #     player_1_move == false
        #     puts "Sorry, please select a valid move."
        #     player_1_move = gets.chomp.to_i
        #   elsif player1.EXP < 30 && player_1_move > 7
        #     player_1_move == false
        #     puts "Sorry, please select a valid move."
        #     player_1_move = gets.chomp.to_i
        #   else
        #     player_1_move == true
        #   end
        # end


      pid = fork{ exec 'afplay', "media/Pickup_Coin53.wav" }
      puts "#{player2.name}: ".blue.bold + "#{player_2_points} points.".green
      puts "Pick your move!"
      puts "*".blue*80
        if player2.EXP < 15
          DanceMove.all.select {|element| puts "#{element.id}. #{element.name}, #{element.difficulty}, #{element.point_value} pts" if element.difficulty == "Easy" }
          puts "*".blue*80
        elsif player2.EXP >= 15 && player1.EXP < 30
          DanceMove.all.select {|element| puts "#{element.id}. #{element.name}, #{element.difficulty}, #{element.point_value} pts" if element.difficulty == "Easy" || element.difficulty == "Medium"}
          puts "*".blue*80
        else player2.EXP >= 30
          DanceMove.all.select {|element| puts "#{element.id}. #{element.name}, #{element.difficulty}, #{element.point_value}"}
          puts "*".blue*80
        end
      player_2_move = gets.chomp.to_i
      pid = fork{ exec 'afplay', "media/Pickup_Coin53.wav" }

      first_move = DanceMove.find(player_1_move)
      second_move = DanceMove.find(player_2_move)
      # Rolls random number to decide if move was a success
      # Awards points if move was success
      puts ""
      puts ""
      puts "#{player1.name} ".red + "is dancing!"
      sleep(2)
      if miss?(first_move)
        puts "Sorry, you blew it!"
        puts "0 points ".green + "for that whack move..."
        pid = fork{ exec 'afplay', "media/Hit_Hurt145.wav" }
        puts ""
      else
        puts "Damn, son!"
        player_1_points += first_move.point_value
        puts "#{first_move.point_value} points ".green +  "for doing #{first_move.name}!"
          pid = fork{ exec 'afplay', "media/Pickup_Coin57.wav" }
        puts ""
      end

      puts "#{player2.name} ".blue + "is dancing!"
      sleep(2)
      if miss?(second_move)
        puts "Sorry, you blew it!"
        puts "0 points ".green + "for that whack move..."
        pid = fork{ exec 'afplay', "media/Hit_Hurt145.wav" }
        puts ""
        puts ""
      else
        puts "Damn son!"
        player_2_points += second_move.point_value
        puts "#{second_move.point_value} points ".green + "for doing #{second_move.name}!"
        pid = fork{ exec 'afplay', "media/Pickup_Coin57.wav" }
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
      pid = fork{ exec 'afplay', "media/Pickup_Coin57.wav" }
      puts "#{player1.name} wins!".red.on_white.blink.bold
      puts "#{player2.name} got served!".blue.on_white.blink.bold
      player1.wins += 1
      player1.EXP += 10
      player2.EXP += 5
      player1.save
      player2.save
    elsif points_2 > points_1
      pid = fork{ exec 'afplay', "media/Pickup_Coin57.wav" }
      puts "#{player2.name} wins!".blue.on_white.blink.bold
      puts "#{player1.name} got served!".red.on_white.blink.bold
      player2.wins += 1
      player2.EXP += 10
      player1.EXP += 5
      player2.save
      player1.save
    else
      puts "Its a tie!"
    end
    puts "*".blue*80
    puts ""
    pid = fork{ exec 'killall', "afplay" }
    game = Game.new
    game.welcome
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
