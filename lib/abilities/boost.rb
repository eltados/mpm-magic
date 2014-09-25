class Boost < Ability


  def description
    "This creature get a +1 / +1 counter every time it hit the player"
  end

  def when_hits_player(*args)
    card.toughness += 1
    card.strength += 1
  end

end
