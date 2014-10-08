class Fight

  def initialize(attacker , defender)
    @attacker = attacker
    @defender = defender
    @reports = []
  end

  def fight!

    @attacker.flags[:unassigned_blocking_damage] -=  resolve_dmg( @attacker, @defender)
    resolve_dmg( @defender, @attacker)

    @attacker.event :blocked
    @reports
  end

  def self.attack_player!(creature , player)
    player.hits_player!( creature.attack , creature )
  end

  def resolve_dmg(attacker , defender)
    attack = attacker.attack

    attack = attacker.flags[:unassigned_blocking_damage] if attacker.flags[:unassigned_blocking_damage]

    dmg = defender.health >= attack ?  attack : defender.health
    defender.hit! dmg

    @reports << "#{attacker.name} deals #{dmg} damage to #{defender.name}"

    attacker.event :hits_creature, defender , dmg

    return  dmg
  end

end
