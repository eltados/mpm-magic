class Combat < Phase

  def initialize(options={})
    @name = "Combat"
    @action = "play"
  end

  def execute
  end

  def auto
    $world.current_player.creatures.select { |c| c.can? (Attack) }.size == 0
  end

end
