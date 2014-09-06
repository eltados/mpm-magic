class Spell < Card

  def initialize(owner=nil)
    super(owner)
  end


  def when_phase_ends
    @owner.move_to_graveyard! self
  end


end
