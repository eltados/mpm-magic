class Trample < Ability

  def description
    "This creature does extra player damage when blocked"
  end

  def when_blocked_finished(*args)
    card.player.opponent.hits_player!( card.flags[:unassigned_blocking_damage] , card )
  end


  def value
    card.attack / 2
  end

end
