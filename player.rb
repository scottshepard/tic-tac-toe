class Player 
  def initialize(name)
    @name = name
    @moves = []
  end
 
  def name
    @name
  end

  def moves
    @moves
  end

  def move!(space)
    (@moves << space).compact!
  end

  def play_middle!
    self.move!(5)
  end
end