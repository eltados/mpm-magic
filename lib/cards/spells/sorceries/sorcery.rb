class Sorcery < Spell

  def initialize(owner=nil)
    super(owner)
    @mana_produced = 1
  end


  def produce!
    tap!
    owner.mana_pool.mana += @mana_produced
  end

  def can_be_played
    owner.playing? && ( phase.is_a?(Pre) ||
        phase.is_a?(Post) ||
        phase.is_a?(DiscardPhase)  ) &&  !owner.flags[:has_played_a_land_this_turn]
  end

  def play!
    owner.flags[:has_played_a_land_this_turn] = true
  end

end
