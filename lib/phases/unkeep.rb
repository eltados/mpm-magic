class Unkeep < Phase

  def initialize(options={})
    @name = "Unkeep"
  end

  def execute
    $world.playing_player.unkeep!
    $world.p1.permanents.map &:unkeep!
    $world.p2.permanents.map &:unkeep!
  end

end
