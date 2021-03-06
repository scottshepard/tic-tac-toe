class Board
  def initialize(player1, player2)
    @moves = ['1','2','3','4','5','6','7','8','9']
    @wins = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
    @player1 = player1
    @player2 = player2
  end

  def update!
    @player1.moves.each {|move| @moves[move-1] = 'X'}
    @player2.moves.each {|move| @moves[move-1] = 'O'}
  end

  def display
    self.update!
    print "\n"
    @moves.each_slice(3).with_index do |row, index|
      puts row.shift + "|" + row.shift + "|" + row.shift
      puts "-|-|-" unless index == 2
    end
    print "\n"
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

  def winning_move(player)
    if player.moves.length >= 2
      @wins.each do |win| 
        win.each do |move|
          return move if ((win - [move]) - player.moves).empty? && space_open?(move)
        end
      end
    end
    false
  end

  def space_open?(space)
    @moves[space - 1] == space.to_s
  end

  def moves
    @moves
  end

  def is_full?
    @player1.moves.length + @player2.moves.length >= 9
  end

  def is_middle_open?
    space_open?(5)
  end

  # this doesn't work somehow?
  def corner_open
    case 
    when space_open?(1)
      1
    when space_open?(3)
      3
    when space_open?(7)
      7
    when space_open?(9)
      9
    end
  end  
end