class Unkeep < Phase

  def initialize(options={})
    @name = "Unkeep"
  end

  def execute
    $world.playing_player.unkeep!
    $world.playing_player.permanents.map &:unkeep!
  end

end
