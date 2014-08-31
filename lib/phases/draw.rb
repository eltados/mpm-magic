class Draw < Phase

  def initialize
    @name = "Draw"
  end

  def execute
    $world.playing_player.draw!
  end

end
