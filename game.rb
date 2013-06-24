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
    if num_players == 1
      @player1 = Player.new(gets.chomp)
      @player2 = Player.new("computer")
      @board = Board.new(@player1, @player2)
      print "Would you like to go first or second?: "
      one_player_game(get_preference)
    else
      @player1 = Player.new(gets.chomp)
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
    if (move = @board.winning_move(@player1))
      @player2.move!(move)
    elsif (move = @board.winning_move(@player2))
      @player2.move!(move)
    elsif @board.is_middle_open?
      @player2.play_middle!
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

  def play_round(p1, p2)
    @board.display
    print "#{p1.name}'s move: "
    move = gets.chomp.to_i
    unless [1,2,3,4,5,6,7,8,9].include? move  
      puts "Invalid move, please play again"
      play_round(p1, p2)
    end
    unless (p1.moves.include? move) or (p2.moves.include? move)
      p1.move!(move)
    else
      puts "Space already taken please play again"
      play_round(p1, p2)
    end
  end

  def rules
    puts "Welcome to Tic Tac Toe!"
    puts "You will be playing against the computer or another player."
    puts "The board will look like a square of numbers."
    puts "When prompted please select the number of the space you wish to place your shape."
  end
  
  def test
    p1 = Player.new("Scott")
    p2 = Player.new("Kelly")
    board = Board.new
    board.display(p1,p2)
    p1.move!(1)
    p1.move!(5)
    p1.move!(7)
    print p1.moves
    puts board.three_in_a_row?(p1)
  end
  Game.new.play
end