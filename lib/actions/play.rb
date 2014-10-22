class Play < Action

  def initialize(owner=nil)
    super(owner)
    @name = "Play"
    @img ="play.png"
    @description ="Play this card"
    @priority =1
  end

  def can_be_activated
     player.actionable? && card.in_hand? && card.can_be_played && !already_played?
  end


  def pay!
    card.pay_cost!
  end

  def execute!
    super
    player.play! card
  end


end
