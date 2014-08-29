class ResolveCombat < Phase

  def initialize(options={})
    @name = "Resolve Combat"
  end

  def execute

    $world.opponent.creatures.select { |c| c.flags[:blocking] }.each do |creature|
      Fight.fight!(creature , creature.flags[:blocked_creature] )
    end

    $world.playing_player.creatures.select { |c| c.flags[:attacking] && !c.flags[:blocked] }.each do |creature|
      Fight.attack_player!(creature , $world.opponent )
    end
  end

  def auto
    true
  end

end
