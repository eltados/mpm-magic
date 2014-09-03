class Discard < Action

  def initialize(owner=nil)
    super(owner)
    @name = "Discard"
    @img ="discard.png"
    @description ="Discard this card"
    @priority = 3
  end

  def can_be_activated
    super && player.playing? && card.in_hand? && world.turn.phase.is_a?(DiscardPhase) &&  player.hand.size >= 8
  end

  def execute!
    super
    player.discard! card
    world.turn.next!
  end

end
