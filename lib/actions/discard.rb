class Discard < Action

  def initialize
    @name = "Discard"
    @img ="discard.png"
    @description ="Discard this card"
    @priority = 3
  end

  def actionnable?
    super && card.owner.playing? && card.in_hand? && $world.turn.phase.is_a?(DiscardPhase) &&  card.owner.hand.size >= 8
  end

  def execute!
    $world.p1.discard! card
    $world.turn.next!
  end

end
