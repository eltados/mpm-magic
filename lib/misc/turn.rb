class Turn
  attr_accessor :current_phase, :number
  @@phases = [ Untap.new , Unkeep.new, Draw.new , Pre.new , Combat.new, BlockPhase.new, ResolveCombat.new, Post.new , DiscardPhase.new , ChangePlayer.new ]


  def initialize
    @current_phase = 0
    @number = 1
  end

  def next!
    return false if !phase.can_pass_to_next?
    @current_phase += 1
    end_turn! if @current_phase >= @@phases.size
    phase.execute
    $world.clean_up!
    next! if phase.auto
  end

  def self.phases
    @@phases
  end


  def phase
    @@phases[@current_phase]
  end

  def end_turn!
    @current_phase = -1
    @number += 1
    next!
  end

end
