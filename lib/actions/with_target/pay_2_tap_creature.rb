class Pay2TapCreature < ActionWithTarget

  def initialize(owner=nil)
    super(owner)
    @name = "Tap"
    @img ="tap.png"
    @description = "{3}, {Tap}: Untap target creature."
    @priority =2
    @cost = 3
  end

  def can_be_activated
    card.in_play?  && card.player.mana_pool.can_pay?(@cost)
  end


  def can_target(target)
      target.is_a?(Creature) && target.in_play? && !target.tapped?
  end

  def execute_with_target!(target)
    super(target)
    card.player.mana_pool.pay! @cost
    target.tap!
    player.target_action =nil
  end


end
