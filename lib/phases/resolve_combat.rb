class ResolveCombat < Phase

  def initialize(turn=nil)
    super(turn)
    @name = "Resolve Combat"
  end

  def execute

    world.opponent.creatures.select { |c| c.flags[:blocking] }.each do |defending_creature|
      attacking_creature = defending_creature.flags[:blocked_creature]
      Fight.fight!(attacking_creature , defending_creature )
    end

    world.playing_player.creatures.select { |c| c.flags[:attacking] && c.flags[:blocked]  }.each do |creature|
      creature.event :blocked_finished
    end

    world.playing_player.creatures.select { |c| c.flags[:attacking] && !c.flags[:blocked] }.each do |creature|
      Fight.attack_player!(creature , world.opponent )
    end
  end

  def auto
    true
  end

end
