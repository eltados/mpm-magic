class Discard < Action

  def initialize(owner=nil)
    super(owner)
    @name = "Discard"
    @img ="discard.png"
    @description ="Discard this card"
    @priority = 3
  end

  def can_be_activated
    player.playing? && card.in_hand? &&  phase.is_a?(DiscardPhase) &&  player.hand.size >= 8
  end

  def execute!
    super
    player.discard! card
  end

  def skip?
    false
  end

end
