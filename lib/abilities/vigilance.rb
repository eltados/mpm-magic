class Vigilance < Ability

  def description
    "Attacking doesn't cause this creature to tap."
  end

  def attack_requires_tap( original )
    false
  end

  def value
    1
  end

end
