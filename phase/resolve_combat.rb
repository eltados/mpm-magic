class ResolveCombat < Phase

  def initialize(options={})
    @name = "Resolve Combat"
  end

  def execute
    $world.playing_player.creatures.select { |c| c.flags[:attacking] }.each do |creature|
      Fight.attack_player!(creature , $world.opponent )
    end
  end

  def auto
    true
  end

end
