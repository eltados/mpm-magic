class Vigilance < Ability

  def description
    "Attacking doesn't cause this creature to tap."
  end

  def attack_requires_tap
    false
  end

end
