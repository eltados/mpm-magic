class Land < Card
  attr_accessor :mana_produced

  def initialize(owner=nil)
    super(owner)
    add_action Produce.new
    @mana_produced = 1
  end

  def can_be_played
    player.playing? && ( phase.is_a?(Pre) ||  phase.is_a?(Post) || phase.is_a?(DiscardPhase)  ) &&  !owner.flags[:has_played_a_land_this_turn]
  end

  def play!
    owner.flags[:has_played_a_land_this_turn] = true
  end

end
