class Draw < Action

  def initialize(owner=nil)
    super(owner)
    @name = "Draw"
    @img ="draw.png"
    @description ="{Tap} : Draw a card"
    @priority =2
  end

  def can_be_activated
    super && card.in_play? && (
      phase.is_a?(Pre) || phase.is_a?(Combat) || phase.is_a?(Post) || phase.is_a?(BlockPhase)
   )  &&  card.can_be_activated && player.active?
  end


  def execute!
    super
    card.tap!
    player.draw!(card)
  end


end
