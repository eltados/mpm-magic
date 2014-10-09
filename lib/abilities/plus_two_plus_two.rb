class PlusTwoPlusTwo < Ability


  def description
    "This creature get a +2 / +2."
  end


  def toughness(original)
    original + 2
  end

  def strength(original)
    original + 2
  end


end
