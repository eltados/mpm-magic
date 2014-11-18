class Flying < Ability

  def description
    "The creature can only be blocked by flying creatures or creature with reach"
  end

  def can_be_blocked_by(original, creature)
    original  && creature.abilities.find{ |a| a.class == Flying || a.class == Reach } != nil
  end
  def value
    2
  end

end
