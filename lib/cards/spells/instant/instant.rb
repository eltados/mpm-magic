class Instant < Spell

  def initialize(owner=nil)
    super(owner)
  end

  def execute_with_target!(target)
    self.flags[:spell_target] = target
    player.target_action =nil
  end




end
