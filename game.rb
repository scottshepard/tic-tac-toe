require_relative 'board'
require_relative 'player'

class Game
  def play
    rules
    print "Will you be playing one player or two player?: "
    num_players = gets.chomp.to_i
    unless num_players == 1 || 2
      puts "Invalid number of players"
      num_players = gets.chomp.to_i
    end
    print "Enter player 1's name: "
    @player1 = Player.new(gets.chomp)
    if num_players == 1
      @player2 = Player.new("computer")
      @board = Board.new(@player1, @player2)
      print "Would you like to go first or second?: "
      one_player_game(get_preference)
    else
      print "Enter player 2's name: "
      @player2 = Player.new(gets.chomp)
      @board = Board.new(@player1, @player2)
      two_player_game
    end
  end

  def one_player_game(preference)
    if preference == 1
      play_round(@player1, @player2)
      return if game_over?
      play_computer_round
      return if game_over?
    else
      play_computer_round
      return if game_over?
      play_round(@player1, @player2)
      return if game_over?
    end
    one_player_game(preference)
  end

  def play_computer_round
    @board.update!
    if (move = @board.winning_move(@player2))
      @player2.move!(move)
    elsif (move = @board.winning_move(@player1))
      @player2.move!(move)
    elsif @board.is_middle_open?
      @player2.play_middle!
      move = 5
    elsif (move = @board.corner_open)
      @player2.move!(move)
    end
    puts "The Computer has gone at space #{move}"
  end

  def get_preference
    preference = gets.chomp.to_i
    unless preference == 1 || 2
      print "Invalid choice, please choose again: "
      get_preference
    end
    preference
  end

  def two_player_game
    play_round(@player1, @player2)
    return if game_over?
    play_round(@player2, @player1)
    return if game_over?
    two_player_game 
  end

  def play_round(p1, p2)
    @board.display
    print "#{p1.name}'s move: "
    move = gets.chomp.to_i
    unless [1,2,3,4,5,6,7,8,9].include? move  
      puts "Invalid move, please play again"
      play_round(p1, p2)
    end
    if (p1.moves.include? move) or (p2.moves.include? move)
      puts "Space already taken please play again"
      play_round(p1, p2)
    else
      p1.move!(move)
    end
  end

  def game_over?
    if @board.is_full?
      puts "Cats game, no winner"
      @board.display
      true
    elsif @board.three_in_a_row?(@player1)
      puts "#{@player1.name} wins!"
      @board.display
      true
    elsif @board.three_in_a_row?(@player2)
      puts "#{@player2.name} wins!"
      @board.display
      true
    else
      false
    end
  end

  def rules
    puts "Welcome to Tic Tac Toe!\nYou will be playing against the computer or another player.\nThe board will look like a square of numbers.\nWhen prompted please select the number of the space you wish to place your shape."
  end
  Game.new.play
end