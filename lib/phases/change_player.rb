class ChangePlayer < Phase

  def initialize(options={})
    @name = "End turn"
  end

  def execute
    $world.logs << "**** #{$world.playing_player.name} passes him turn"
    $world.switch_playing_player!
  end

end
