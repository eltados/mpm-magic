class Sorcery < Spell

  def initialize(owner=nil)
    super(owner)
  end

  def can_be_played
    super && player.playing? && ( phase.is_a?(Pre) || phase.is_a?(Post) ) && owner.mana_pool.can_pay?(self.cost)
  end

end
