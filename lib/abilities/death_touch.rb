class DeathTouch < Ability

  def description
    "Any amount of damage it deals to a creature is enough to destroy it."
  end

  def when_hits_creature(*args)
    creature, dommage = args.flatten
    creature.destroy! if dommage > 0
  end


end
