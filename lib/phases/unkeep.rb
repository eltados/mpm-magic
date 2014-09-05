class Unkeep < Phase

  def initialize(turn=nil)
    super(turn)
    @name = "Unkeep"
  end

  def execute
    world.when_phase_unkeep
  end

end
