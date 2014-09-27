class DeathTouch < Ability

  def description
    "Any amount of damage it deals to a creature is enough to destroy it."
  end

  def when_hits_creature(*args)
    creature, damage = args.flatten
    creature.destroy! if damage > 0
  end


end
