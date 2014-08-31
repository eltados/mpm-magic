class Draw < Phase

  def initialize(turn=nil)
    super(turn)
    @name = "Draw"
  end

  def execute
    world.playing_player.draw!
  end

end
