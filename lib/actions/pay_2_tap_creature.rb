class Pay2TapCreature < Action

  def initialize(owner=nil)
    super(owner)
    @name = "Tap"
    @img ="tap.png"
    @description = "{2}, {Tap}: Untap target creature."
    @priority =2
    @cost = 2
  end

  def required_targets
    1
  end

  def can_be_activated
    super && card.in_play?  && card.can_be_activated && card.player.mana_pool.can_pay?(@cost)
  end


  def can_target(target)
     can_be_activated && target.is_a?(Creature) && target.in_play?
  end

  def pay!
    card.tap!
    player.mana_pool.pay! @cost
  end

  def execute!
    super
    target.tap!
  end

end
