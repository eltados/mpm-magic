class SummoningSickness < Ability

  def description
    "This creature is affected by the summoning sickness and cannot attack the first turn"
  end

  def permanent?
    false
  end

  def can_attack(original)
    false || ( card.abilities.any?{ |a| a.is_a?(Haste) } && original )
  end

  def can_be_activated(original)
    false || ( card.abilities.any?{ |a| a.is_a?(Haste) } && original )
  end


  def value
    0
  end

end
