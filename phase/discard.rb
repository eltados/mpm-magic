class DiscardPhase < Phase

  def initialize(options={})
    @name = "Discard"
  end

  def execute
  end

  def cannot_pass_to_next_because
    "You have too many cards. Please discard a card." if $world.playing_player.hand.size >= 8
  end

end
