class Unkeep < Phase

  def initialize(options={})
    @name = "Unkeep"
  end

  def execute
    $world.current_player.permanents.map &:unkeep!
  end

end
