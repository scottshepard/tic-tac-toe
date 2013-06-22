require_relative 'board'
require_relative 'player'

class Game

  def play_game
    rules
    board = Board.new
    print "Will you be playing one player or two player?: "
    num_players = gets.chomp.to_i
    unless num_players == 1 || 2
      puts "Invalid number of players"
      num_players = gets.chomp.to_i
    end
    print "Enter player 1's name: "
    player1 = Player.new(gets.chomp)
    if num_players == 1
      one_player_game(player1, board)
    else
      print "Enter player 2's name: "
      player2 = Player.new(gets.chomp)
      two_player_game(player1, player2, board)
    end
  end

  def one_player_game(player1, board)
    computer = Player.new("computer")
    board.display(player1, computer)
  end

  def two_player_game(player1, player2, board)
    play_round(player1, player2, board)
    return if game_over?(player1, player2, board)
    play_round(player2, player1, board)
    return if game_over?(player1, player2, board)
    two_player_game(player1, player2, board) 
  end

  def game_over?(player1, player2, board)
    if board.is_full?(player1, player2)
      puts "Cats game, no winner"
      true
    elsif board.three_in_a_row?(player1)
      puts "#{player1.name} wins!"
      true
    elsif board.three_in_a_row?(player2)
      puts "#{player2.name} wins!"
      true
    else
      false
    end
  end

  def play_round(p1, p2, board)
    board.display(p1, p2)
    print "#{p1.name}'s move: "
    move = gets.chomp.to_i
    unless [1,2,3,4,5,6,7,8,9].include? move  
      puts "Invalid move, please play again"
      play_round(p1,p2)
    end
    unless (p1.moves.include? move) or (p2.moves.include? move)
      p1.move!(move)
    else
      puts "Space already taken please play again"
      play_round(p1,p2)
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


  Game.new.play_game

end