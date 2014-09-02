class NightmareAbility < Ability

  def description
    "The nightmare as a strenght and toughness equals to the number of Land you possess"
  end

  def toughness(original)
    card.player.lands.size
  end

  def strength(original)
    card.player.lands.size
  end

end
