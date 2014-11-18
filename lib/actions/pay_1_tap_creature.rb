class Pay1TapCreature < Action

  def initialize(owner=nil)
    super(owner)
    @name = "Tap"
    @img ="tap.png"
    @description = "{1}, {Tap}: Tap target creature."
    @priority =2
    @cost = 1
  end

  def required_targets
    1
  end

  def can_be_activated
    super && card.in_play?  && card.can_be_activated && card.player.mana_pool.can_pay?(@cost)
  end


  def can_target(target)
     target.is_a?(Creature) && target.in_play? &&  !target.tapped?
  end

  def pay!
    card.tap!
    player.mana_pool.pay! @cost
  end

  def execute!
    super
    target.tap!
  end

  def value
    2
  end

end
