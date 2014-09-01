class Unkeep < Phase

  def initialize(turn=nil)
    super(turn)
    @name = "Unkeep"
  end

  def execute
    world.playing_player.unkeep!
    world.p1.permanents.map &:unkeep!
    world.p2.permanents.map &:unkeep!
    # world.playing_player.permanents.map &:when_phase_unkeep
  end

end
