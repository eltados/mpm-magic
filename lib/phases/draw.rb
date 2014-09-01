class Draw < Phase

  def initialize(turn=nil)
    super(turn)
    @name = "Draw"
  end

  def execute
    world.when_phase_draw 
  end

end
