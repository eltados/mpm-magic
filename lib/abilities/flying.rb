class Flying < Ability

  def description
    "The creature can only be blocked by flying creatures"
  end

  def can_be_blocked_by(original, creature)
    original  && creature.abilities.find{ |a| a.class == Flying } != nil
  end


end
