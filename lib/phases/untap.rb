class Untap < Phase

  def initialize(turn=nil)
    super(turn)
    @name = "Untap"
  end

  def execute
     world.when_phase_untap
  end

end
