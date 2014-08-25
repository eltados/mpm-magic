require_relative 'ability'
require_relative 'summoning_sickness'
class Haste < Ability

  def initialize
    @name = "Haste"
    @img ="haste.png"
  end

  def play!
    @owner.remove_ability SummoningSickness
  end

end
