class Spell < Card

  def initialize(owner=nil)
    super(owner)
  end


  def when_phase_ends(*args)
    @owner.move_to_graveyard! self
  end

  def abilities
    [Struct.new(:name, :img, :description , :permanent?)
           .new(self.name , "#{self.type}.png" , self.description, true)]
  end

  def can_be_played
     owner.mana_pool.can_pay?(self.cost)
  end

  def positive?
    true
  end

end
