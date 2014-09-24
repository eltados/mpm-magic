class Haste < Ability

  def description
    "This creature does extra player dommage when blocked"
  end

  def when_played(*args)
    card.abilities.reject!{ |a|  a.class == SummoningSickness}
  end

end
