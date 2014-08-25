class Draw < Phase

  def initialize(options={})
    @name = "Draw"
    @action = "play"
  end

  def execute
    $world.current_player.draw!
  end

end
