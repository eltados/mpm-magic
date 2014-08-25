class DiscardPhase < Phase

  def initialize(options={})
    @name = "Discard"
    @action = "discard"
  end

  def execute
    puts "Discard"
  end

  def cannot_pass_to_next_because
    "You have too many cards. Please discard a card." if $world.current_player.hand.size >= 8
  end

end
