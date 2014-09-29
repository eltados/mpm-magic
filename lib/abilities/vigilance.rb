class Vigilance < Ability

  def description
    "Attacking doesn't cause this creature to tap."
  end

  def attack!
    flags[:attacking] = true
  end

  def undo_attack!
    flags[:attacking] = nil
  end


end
