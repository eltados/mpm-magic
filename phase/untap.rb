class Untap < Phase

  def initialize(options={})
    @name = "Untap"
  end

  def execute
    $world.playing_player.permanents.map &:untap!
  end

end
