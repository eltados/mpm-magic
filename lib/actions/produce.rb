class Produce < Action

  def initialize(owner=nil)
    super(owner)
    @name = "Produce"
    @img ="produce.png"
    @description ="Produce mana"
    @priority =1
  end

  def can_be_activated
    super && card.in_play? &&  !card.tapped?
  end

  def execute!
    card.produce!
  end


end
