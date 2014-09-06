class Play < Action

  def initialize(owner=nil)
    super(owner)
    @name = "Play"
    @img ="play.png"
    @description ="Play this card"
    @priority =1
  end

  def can_be_activated
    card.in_hand? && card.can_be_played
  end

  def execute!
  super
    player.play! card
  end


end
