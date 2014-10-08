class ResolveCombat < Phase

  def initialize(turn=nil)
    super(turn)
    @name = "Resolve Combat"
  end

  def execute

    world.creatures.select { |c| c.flags[:attacking] && c.flags[:blocked]  }.each do |attacking_creature|
      fight_report = []
      attacking_creature.flags[:unassigned_blocking_damage] = attacking_creature.attack
      defending_creatures = world.opponent.creatures.select { |c| c.flags[:blocked_creature] == attacking_creature }.shuffle.sort_by(&:value).reverse
      defending_creatures_hash = Hash[*defending_creatures.map{ |c| [c,:not_done] }.flatten]
      while defending_creatures_hash.values.any?{ |v| :not_done == v }
        defending_creature = defending_creatures_hash.keys.find{ |d| defending_creatures_hash[d]  == :not_done && d.alive? && d.health <= attacking_creature.flags[:unassigned_blocking_damage] }
        defending_creature = defending_creatures_hash.keys.select{ |d| defending_creatures_hash[d] == :not_done }.first if defending_creature.nil?
        f = Fight.new(attacking_creature , defending_creature )
        fight_report << f.fight!
        defending_creatures_hash[defending_creature] = :done
      end
      world.log Log.new(description: fight_report.flatten.join('\n'), card: attacking_creature, action:Attack.new , target:Attack.new )

    end

    world.playing_player.creatures.select { |c| c.flags[:attacking] && c.flags[:blocked]  }.each do |creature|
      creature.event :blocked_finished
    end

    world.opponent.creatures.select { |c| c.flags[:blocking]  }.each do |creature|
      creature.event :blocking_finished
    end

    world.playing_player.creatures.select { |c| c.flags[:attacking] && !c.flags[:blocked] }.each do |creature|
      Fight.attack_player!(creature , world.opponent )
    end
  end

  def auto
    true
  end

end
