class Play < Action

  def initialize(owner=nil)
    super(owner)
    @name = "Play"
    @img ="play.png"
    @description ="Play this card"
    @priority =1
  end

  def can_be_activated
     card.in_hand? && card.can_be_played && !already_played? && ( player.active? || world.stack.empty? )
  end

  def pay!
    card.pay_cost!
  end

  def react_time
    return 3000 if card.is_a?(Land)
    5000
  end

  def execute!
    super
    player.play! card
  end


end
