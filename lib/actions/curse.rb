class Curse < Action

  def initialize(owner=nil)
    super(owner)
    @name = "Curse"
    @img ="curse.png"
    @description ="{Tap}: Target creature other than Sorceress Queen becomes 0/2 until end of turn."
    @priority =2
  end


  def can_be_activated
    super && card.can_be_activated
  end

  def can_target(target)
      target.is_a?(Creature) && target.in_play? && !target.is_a?(SorceressQueen)
  end

  def pay!
    card.tap!
  end

  def required_targets
    1
  end

  def execute!
    super
    target.health = 2
    target.attack = 0
  end

  def value
    4
  end

end
