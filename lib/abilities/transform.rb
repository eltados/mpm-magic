class TransformAbility < Ability


  def initialize(card)
    super(card)
    @action = TransformAction.new(card)
  end

  def description
    "{tap} : attack of target creature is multipled by 2"
  end


  def actions(original)
    original += [@action]
  end

  def img
    "transform.png"
  end

end
