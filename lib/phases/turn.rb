class Turn
  attr_accessor :current_phase, :number, :world ,:phases


  def initialize(world=nil)
    @phases = [Untap, Unkeep, Draw , Pre, Combat, BlockPhase, ResolveCombat, Post , DiscardPhase , ChangePlayer].map do |phase|
      phase.new self
    end

    @current_phase = 2
    @number = 1
    @world = world
  end



  def next!
    return false if !phase.can_pass_to_next?
    @current_phase += 1
    end_turn! if @current_phase >= @phases.size
    phase.execute
    world.clean_up!
    next! if phase.auto
  end


  def phase
    @phases[@current_phase]
  end

  def end_turn!
    @current_phase = -1
    @number += 1
    next!
  end

end
