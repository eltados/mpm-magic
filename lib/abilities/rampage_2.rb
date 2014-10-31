class Rampage2 < Ability


  def description
    "Rampage 2 (Whenever this creature becomes blocked, it gets +2/+2 until end of turn for each creature blocking it beyond the first.)"
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
