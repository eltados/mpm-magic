class SummoningSickness < Ability

  def initialize(owner=nil)
    super(owner)
    @name = "Summoning Sickness"
    @img ="spiral.png"
    # @img = "this creature cannot"
  end

  def permanent?
    false
  end

end
