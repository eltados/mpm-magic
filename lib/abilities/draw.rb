class DrawAbility < Ability


  def description
    "{tap} : draw card"
  end


  def actions(original)
    original += [DrawAction.new(card)]
  end

  def img
    "draw.png"
  end

end
