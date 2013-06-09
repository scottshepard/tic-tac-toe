class Game
  
  def play
    rules
    board = Board.initilize
    print "Will you be playing one player or two player?:"
    num_players = gets.chomp.to_i
    unless num_players == 1 || 2
      puts "Invalid number of players"
      num_players = gets.chomp.to_i
    end
    print "Enter player 1's name: "
    player1 = Player.create(gets.chomp)
    if num_players == 1
      oneplayergame(player1, board)
    else
      print "Enter player 2's name: "
      player2 = Player.create(gets.chomp)
      twoplayergame(player1, player2, board)
    end
  end

  def one_player_game(player1, board)
    computer = Player.create("computer")
  end

  def two_player_game(player1, player2, board)
    until board.is_full?(player1, player2) || board.three_in_a_row(player1, player2)
      play_round(player1, player2)
      board.display(player1,player2)
      unless board.is_full(player1, player2) || board.three_in_a_row(player1, player2)
        play_round(player2, player1)
        board.display(player1, player2)
      end

    
    end
  end

  def play_round(p1,p2)
    print "your move:"
    move = gets.chomp.to_i
    unless [1,2,3,4,5,6,7,8,9].include? move  
      puts "Invalid move, please play again"
      playround(p1,p2)
    end
    unless (p1.moves.include? move) or (p2.moves.include? move)
      p1.move!(move)
    else
      puts "Space already taken please play again"
      playround(p1,p2)
    end
  end

  def rules
    puts "Welcome to Tic Tac Toe!"
    puts "You will be playing against the computer or another player."
    puts "The board will look like a square of numbers."
    puts "When prompted please select the number of the space you wish to place your shape."
  end

end