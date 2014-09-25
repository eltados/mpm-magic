class Fight


  def self.fight!(attacker , defender)
    resolve_dmg( defender, attacker)
    resolve_dmg( attacker, defender)

    attacker.flags[:unassigned_blocking_dommage] = defender.health < 0 ?  - defender.health  : 0
    attacker.event :blocked
  end

  def self.attack_player!(creature , player)
    player.hits_player!( creature.attack , creature )
  end

  def self.resolve_dmg(attacker , defender)
    defender.hit! attacker.attack
    attacker.event :hits_creature, defender , attacker.attack
  end

end
