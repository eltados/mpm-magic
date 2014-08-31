class Combat < Phase

  def initialize(turn=nil)
    super(turn)
    @name = "Combat"
  end

  def execute
  end

  def auto
    world.playing_player.creatures.select { |c| c.can? (Attack) }.size == 0
  end

end
