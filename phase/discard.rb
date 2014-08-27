class DiscardPhase < Phase

  def initialize(options={})
    @name = "Discard"
    @action = "discard"
  end

  def execute
    # $world.switch_playing_player!
  end

  def cannot_pass_to_next_because
    "You have too many cards. Please discard a card." if $world.playing_player.hand.size >= 8
  end

end
