class BoostAttackAbility < Ability


  def initialize(card)
    super(card)
    @action = BoostAttackAction.new(card)
  end


  def description
    "{1} : gets +1/+0 until end of turn."
  end


  def actions(original)
    original += [@action]
  end

  def img
    "boost.png"
  end

end
