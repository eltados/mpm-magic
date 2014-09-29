class Trample < Ability

  def description
    "This creature does extra player damage when blocked"
  end

  def when_blocked(*args)
    card.player.opponent.hits_player!( card.flags[:unassigned_blocking_damage] , card )
  end

end
