class ActionAbility < Ability


  def initialize(card, action_class)
    super(card)
    @action = action_class.new(card)
  end


  def description
    @action.description
  end


  def actions(original)
    original += [@action]
  end

  def img
    @action.img
  end

end
