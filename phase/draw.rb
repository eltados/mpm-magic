class Draw < Phase

  def initialize(options={})
    @name = "Draw"
  end

  def execute
    $world.playing_player.draw!
  end

end
