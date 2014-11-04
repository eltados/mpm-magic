class Enchantment < Spell

  def initialize(owner=nil)
    super(owner)
  end

  def when_phase_ends(*args)
    # do nothing
  end

  def can_be_played
    super && ( phase.is_a?(Pre) ||
        phase.is_a?(Post) ) && owner.mana_pool.can_pay?(self.cost) && player.playing?
  end

  def positive?
    true
  end


end
