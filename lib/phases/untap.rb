class Untap < Phase

  def initialize(turn=nil)
    super(turn)
    @name = "Untap"
  end

  def execute
     world.playing_player.permanents.map &:untap!
    # world.playing_player.permanents.map &:when_phase_untap
  end

end
