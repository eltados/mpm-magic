class Fight


  def self.fight!(attacker , defender)
    resolve_dmg( defender, attacker)
    resolve_dmg( attacker, defender)
  end

  def self.attack_player!(creature ,player)
    player.health -= creature.attack
    player.world.logs << "#{player.name} loses #{creature.attack} HP (#{creature.name})"
  end

  def self.resolve_dmg(attacker , defender)
    defender.dmg += attacker.attack
  end

end
