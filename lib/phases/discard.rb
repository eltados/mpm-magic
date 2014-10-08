class DiscardPhase < Phase

  def initialize(turn=nil)
    super(turn)
    @name = "Discard"
  end

  def execute
  end

  def cannot_pass_to_next_because
    puts "world.turn.number = #{world.turn.number}"
    "You have too many cards. Please discard a card." if world.active_player.hand.size >= 8 && world.turn.number > 1
  end

end
