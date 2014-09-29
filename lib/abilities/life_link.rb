class LifeLink < Ability

  def description
    "when this creature deal damage gain the same amount of HP"
  end

  def when_hits_player(*args)
    card.player.health += card.flags[:hits_player]
  end

end
