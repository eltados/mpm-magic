require_relative 'action'
class Attack < Action

  def initialize
    @name = "Attack"
    @img ="attack.png"
    @description ="Attack with this card"
    @priority =1
  end

  def actionnable?
    super && card.owner.playing? && card.in_play? && $world.turn.phase.is_a?(Combat) &&  card.activable?
  end

  def execute!
    card.attack!
  end

end
