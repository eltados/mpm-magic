class HealAbility < Ability

  def initialize(owner=nil)
    super(owner)
    @name = "Heal"
    @img ="heal.png"
    @description ="Tap : Gain 1 HP"
  end

  def play!
    card.add_action Heal.new
  end


end
