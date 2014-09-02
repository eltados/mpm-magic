

class SummoningSickness < Ability

  def description
    "This creature is affected by the summoning sickness and cannot attack the first turn"
  end

  def permanent?
    false
  end


  def can_attack(original)
    false
  end

end
