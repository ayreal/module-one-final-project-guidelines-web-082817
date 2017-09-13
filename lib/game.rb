require_relative "dancers.rb"
require "catpix"
class Game

  def welcome
    # Prints welcome message and prompts player to start the game

    puts "Welcome to..."
    sleep(1)
    puts "Dance Battle".bold.blue
    sleep(0.75)
    puts "XTREME".bold.red.blink
    puts ""
    Catpix::print_image "/Users/Lawford/Desktop/Disco People.png",
    :limit_x => 1.0,
    :limit_y => 0,
    :center_x => false,
    :center_y => false,
    :bg_fill => false,
    :resolution => "medium"
    puts ""
    puts "1. Create a Dancer"
    puts "2. Start a Dance Battle"
    puts "3. View Dancer Stats"
    puts "4. Exit"
    menu_answer = gets.chomp

    if menu_answer == "1"
      pid = fork{ exec 'afplay', "/Users/Lawford/Desktop/Pickup_Coin53.wav" }
      Dancer.create_dancer
    elsif menu_answer == "2"
      pid = fork{ exec 'afplay', "/Users/Lawford/Desktop/Pickup_Coin53.wav" }
      player1 = find_player_1
      player2 = find_player_2
      turn = Turn.new
      turn.start_match(player1,player2)
    elsif menu_answer =="3"
      pid = fork{ exec 'afplay', "/Users/Lawford/Desktop/Pickup_Coin53.wav" }
      puts "DANCER STATS".bold.light_blue
      puts "*".blue*80
      Dancer.all.each {|dancer| puts "#{dancer.name} ".red + "Hometown: ".bold + "#{dancer.hometown} " + "Wins: ".bold + "#{dancer.wins} " + "EXP: ".bold + "#{dancer.EXP}"}
      puts "*".blue*80
      puts ""
      welcome
    elsif menu_answer =="4"
      pid = fork{ exec 'afplay', "/Users/Lawford/Desktop/Pickup_Coin53.wav" }
      exit_game
    else
      puts "Please type a valid answer."
      pid = fork{ exec 'afplay', "/Users/Lawford/Desktop/Pickup_Coin53.wav" }
      welcome
    end
  end

  def find_player_1
    puts "Player 1, Select your dancer:"
    Dancer.all.each {|element| puts "#{element.id}. #{element.name}, #{element.hometown}, #{element.EXP}"}
    player_1_pick = gets.chomp.to_i
    pid = fork{ exec 'afplay', "/Users/Lawford/Desktop/Pickup_Coin53.wav" }
    Dancer.find(player_1_pick)
  end

  def find_player_2
    puts "Player 2, Select your dancer:"
    Dancer.all.each {|element| puts "#{element.id}. #{element.name}, #{element.hometown}, #{element.EXP}"}
    player_2_pick = gets.chomp.to_i
    pid = fork{ exec 'afplay', "/Users/Lawford/Desktop/Pickup_Coin53.wav" }
    Dancer.find(player_2_pick)
  end

  def start_game
    #Sends player to character creation/starts the game
    Dancer.create_dancer
    Dancer.create_dancer
  end

  def exit_game
    abort("You left Dance Battle XTREME")
  end


end
