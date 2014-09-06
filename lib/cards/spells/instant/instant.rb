class Instant < Spell

  def initialize(owner=nil)
    super(owner)
  end

  def can_be_played
     owner.mana_pool.can_pay?(self.cost)
  end

end
