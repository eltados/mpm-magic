class Haste < Ability

  def initialize(owner=nil)
    super(owner)
    @name = "Haste"
    @img ="haste.png"
  end

  def play!
    @owner.remove_ability SummoningSickness
  end


end
