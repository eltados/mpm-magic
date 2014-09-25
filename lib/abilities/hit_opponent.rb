class HitOpponent < Ability


  def description
    "The opponent loses 5 HP"
  end

  def when_played(*args)
    opponent.hits_player( 5 , card)
  end

end
