class Trample < Ability

  def description
    "This creature does extra player dommage when blocked"
  end

  def when_blocked(*args)
    card.player.opponent.hits_player!( card.flags[:unassigned_blocking_dommage] , card )
  end

end
