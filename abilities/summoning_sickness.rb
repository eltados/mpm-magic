require_relative 'ability'
class SummoningSickness < Ability

  def initialize
    @name = "Summoning Sickness"
    @img ="spiral.png"
  end

  def permanent?
    false
  end

end
