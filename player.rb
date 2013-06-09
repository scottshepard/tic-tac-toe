class Player
  
  def create(name)
    @name = name
    @moves = []
  end
 
  def name
    @name
  end

  def moves
    @moves
  end

  def move(space)
    @moves[space-1] = space
  end

end