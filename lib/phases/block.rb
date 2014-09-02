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
    attacking_creatures = world.playing_player.creatures.select { |c| c.flags[:attacking]  }
    world.defending_player.creatures.each do |defending_creature|
       return false if defending_creature.can_block_any(attacking_creatures)
    end
    return true
  end

end
