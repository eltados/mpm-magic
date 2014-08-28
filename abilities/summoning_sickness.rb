require_relative 'ability'
class SummoningSickness < Ability

  def initialize
    @name = "Summoning Sickness"
    @img ="spiral.png"
    # @img = "this creature cannot"
  end

  def permanent?
    false
  end

end
