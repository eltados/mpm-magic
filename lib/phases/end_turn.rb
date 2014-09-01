class EndTurn < Phase

  def initialize(turn=nil)
    super(turn)
    @name = "End turn"
  end

  def execute
    world.logs << "**** #{world.playing_player.name} passes him turn"
    world.switch_playing_player!
    world.permanents.map &:when_phase_end_turn
  end

end
