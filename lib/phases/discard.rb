class DiscardPhase < Phase

  def initialize(turn=nil)
    super(turn)
    @name = "Discard"
  end

  def execute
  end

  def cannot_pass_to_next_because
    "You have too many cards.<br/> Please discard a card." if world.playing_player.hand.reject{ |c| c.is_a?(ManaRing)}.size >= 8 
  end

end
