class Hexproof < Ability


  def description
    "Prevents a permanent or player from being the target of spells or abilities played by opponents"
  end

  def value
    !card.flags[:attacking] ? 1 : 0
  end


  def bonus
    card.player.nil? || !card.flags[:blocked] ? 0 :  2 * (card.flags[:blocked_by].size - 1)
  end

  def toughness(original)
    original + bonus
  end

  def strength(original)
    original + bonus
  end

end
