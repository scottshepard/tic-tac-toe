class Board
  def initialize
    @moves = ['1','2','3','4','5','6','7','8','9']
    @wins = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
  end

  def display(player1, player2)
    player1.moves.each {|move| @moves[move-1] = 'X'}
    player2.moves.each {|move| @moves[move-1] = 'O'}
    @moves.each_slice(3) do |row|
      puts row.shift + "|" + row.shift + "|" + row.shift
      puts "-|-|-"
    end
  end

  def three_in_a_row?(player)
    if player.moves.length < 3
      answer = false
    else
      answer = false
      @wins.each do |win|
        answer = true if (win - player.moves).empty?
      end
    end
    answer
  end

  # tests if a player has two moves in a row
  # if it does checks if the third space is occupied
  # returns false if occupied or no two moves in a row
  # returns the number of the third space if it is open
  def winning_move(player)
    answer = false
    if player.moves.length >= 2
      @wins.each do |win|
        for move in win
          answer = move if ((win - [move]) - player.moves).empty?
        end
      end
    end
    if answer 
      if (@moves[answer - 1] == 'X') || (@moves[answer - 1] == 'O')
       answer = false
     end
    end
    answer
  end

  def moves
    @moves
  end

  def is_full?(player1, player2)
    player1.moves.length + player2.moves.length >= 9
  end

  def is_middle_open?
    @moves[4] != '5'
  end  
end