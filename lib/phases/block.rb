class BlockPhase < Phase

  def initialize(turn=nil)
    super(turn)
    @name = "Block"
  end

  def execute
  end

  def after
    world.playing_player.creatures.select { |c| c.flags[:blocked]  }.map(&:when_blocked)
    world.opponent.creatures.select { |c| c.flags[:blocking]  }.map(&:when_blocking)
  end

  def auto
    world.defending_player.creatures.select { |c| c.can? (Block) }.size == 0
  end

end
