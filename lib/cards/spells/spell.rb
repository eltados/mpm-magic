class Spell < Card

  def initialize(owner=nil)
    super(owner)
  end


  def when_phase_ends(*args)
    @owner.move_to_graveyard! self
  end

  def can_be_played
     owner.mana_pool.can_pay?(self.cost)
  end

  def positive?
    true
  end

end
