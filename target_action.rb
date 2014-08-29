class TargetAction
  attr_accessor :actor, :action, :target

  def initialize(actor, action)
    @actor = actor
    @action = action
  end

  def can_target?(card)
    @action.can_target?(card)
  end


end
