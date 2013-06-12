class Board

  def initialize
    @moves = ['1','2','3','4','5','6','7','8','9']
    @wins = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
  end

  def display(player1,player2)
    player1.moves.each {|move| @moves[move-1] = 'X'}
    player2.moves.each {|move| @moves[move-1] = 'O'}
    @moves.each_slice(3) do |row|
      puts row.shift + "|" + row.shift + "|" + row.shift
      puts "-|-|-"
    end
  end

  def three_in_a_row?(player1)
    if player1.moves.length < 3
      answer = false
    else
      answer = false
      @wins.each do |win|
        answer = true if (win - player1.moves).empty?
      end
    end
    answer
  end

  def is_full?(player1,player2)
    player1.moves.length + player2.moves.length >= 9
  end
  
end