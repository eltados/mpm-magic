class DrawAbility < Ability


  def initialize(card)
    @card = card
    @action = DrawAction.new(card)
  end


  def description
    "{tap} : draw card"
  end


  def actions(original)
    original += [@action]
  end

  def img
    "draw.png"
  end

end
