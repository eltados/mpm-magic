class  Monstrosity < Action
  def initialize(owner=nil)
    super(owner)
    @name = "Monstrosity"
    @img ="inner.png"
    @description ="{5}: Monstrosity 1. (If this creature isn't monstrous, put a +1/+1 counter on it and it becomes monstrous.)"
    @priority = 2
    @cost = 5
  end

  def can_be_activated
    super && card.in_play? && !card.permanent_flags["monstrous"] && player.active? && card.player.mana_pool.can_pay?(@cost)
  end

  def pay!
    player.mana_pool.pay! @cost
  end

  def execute!
    super
    card.permanent_flags["monstrous"] =  true
    card.attack += 1
    card.toughness += 1
  end

  def value
    3
  end

end
