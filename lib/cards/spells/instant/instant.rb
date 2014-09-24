class Instant < Spell

  def initialize(owner=nil)
    super(owner)
  end

  def can_be_played
     owner.mana_pool.can_pay?(self.cost)
  end

  def execute_with_target!(target)
    self.flags[:spell_target] = target
    player.target_action =nil
  end

end
