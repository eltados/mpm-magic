class Untap < Phase

  def initialize(turn=nil)
    super(turn)
    @name = "Untap"
  end

  def execute
    world.playing_player.permanents.map &:untap!
  end

end
