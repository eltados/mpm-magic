class Wall < Ability

  def description
    "This creature is a wall and cannot attack"
  end

  def can_attack(original)
    false
  end

  def value
    -2
  end

end
