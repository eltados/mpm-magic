class PlusTwoPlusTwo < Ability


  def description
    "This creature get a +2 / +2."
  end

  def value
    return 3 if card.player.nil?
    card.player.lands.size
  end


  def toughness(original)
    original + 2
  end

  def strength(original)
    original + 2
  end


end
