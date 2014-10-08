class PayTwoManaAnTwoHpDraw < Action

  def initialize(owner=nil)
    super(owner)
    @name = "Draw"
    @img ="draw.png"
    @description ="{2}, Pay 2 life: Draw a card."
    @priority =2
    @cost = 2
  end

  def can_be_activated
    super && card.in_play? && card.player.mana_pool.can_pay?(@cost) && card.player.health > 2
  end

  def execute!
    super
    card.player.mana_pool.pay! @cost
    player.hits_player!(2, card)
    player.draw!
  end


end
