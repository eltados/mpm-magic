class Fight


  def self.fight!(attacker , defender)

    resolve_dmg( defender, attacker)
    resolve_dmg( attacker, defender)

    attacker.flags[:unassigned_blocking_damage] = defender.health < 0 ?  - defender.health  : 0
    attacker.event :blocked
  end

  def self.attack_player!(creature , player)
    player.hits_player!( creature.attack , creature )
  end

  def self.resolve_dmg(attacker , defender)
    dmg = attacker.attack
    dmg = attacker.flags[:unassigned_blocking_damage] if attacker.flags[:unassigned_blocking_damage] != nil && attacker.flags[:unassigned_blocking_damage] > 0
    defender.hit! dmg
    attacker.event :hits_creature, defender , dmg
  end

end
