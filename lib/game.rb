require_relative "dancers.rb"
class Game

  def welcome
    # Prints welcome message and prompts player to start the game
    puts "Welcome to Dance Fuckin Battle"
    puts "1. Start Game."
    puts "2. Exit."
    menu_answer = gets.chomp

    if menu_answer == "1"
      start_game
    elsif menu_answer == "2"
      exit_game
    else
      puts "Please type a valid answer!"
      welcome
    end
  end

  def start_game
    #Sends player to character creation/starts the game
    Dancer.create_dancer
    Dancer.create_dancer
  end

  def help
  #Displays help info

  end
end
