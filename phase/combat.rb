class Combat < Phase

  def initialize(options={})
    @name = "Combat"
  end

  def execute
  end

  def auto
    $world.playing_player.creatures.select { |c| c.can? (Attack) }.size == 0
  end

end
