class Haste < Ability

  def initialize
    @name = "Haste"
    @img ="haste.png"
  end

  def play!
    @owner.remove_ability SummoningSickness
  end

end
