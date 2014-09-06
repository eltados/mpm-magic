class HitAbility < Ability


  def initialize(card)
    super(card)
    @action = HitAction.new(card)
  end


  def description
    "{tap} : deals 1 dommage to target creature"
  end


  def actions(original)
    original += [@action]
  end

  def img
    "hit.png"
  end

end
