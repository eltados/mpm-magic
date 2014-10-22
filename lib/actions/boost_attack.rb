class BoostAttackAction < Action

  def initialize(owner=nil)
    super(owner)
    @name = "Boost Attack"
    @img ="boost.png"
    @description ="{1} : gets +1/+0 until end of turn."
    @priority =2
    @cost = 1
  end

  def can_be_activated
    super && card.in_play? && card.player.mana_pool.can_pay?(@cost)
  end

  def pay!
    card.player.mana_pool.pay! @cost
  end

  def execute!
    super
    card.attack_bonus += 1
  end


end
