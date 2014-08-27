class ChangePlayer < Phase

  def initialize(options={})
    @name = "End turn"
  end

  def execute
    $world.switch_playing_player!
  end

end
