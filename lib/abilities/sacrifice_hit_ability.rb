class SacrificeHitAbility < Ability


  def initialize(card)
    super(card)
    @action = SacrificeHitAction.new(card)
  end


  def description
    "{Sacrify} : deals 4 dommage to target creature"
  end


  def actions(original)
    original += [@action]
  end

  def img
    "hit.png"
  end

end
