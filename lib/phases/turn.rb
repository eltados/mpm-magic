class Turn
  attr_accessor :current_phase, :number, :world ,:phases


  def initialize(world=nil)
    @phases = [Untap, Unkeep, Draw , Pre, Combat, BlockPhase, ResolveCombat, Post , DiscardPhase , EndTurn].map do |phase|
      phase.new self
    end

    @current_phase = 2
    @number = 0
    @world = world
  end



  def next!
    return false if !phase.can_pass_to_next?
    phase.after
    @current_phase += 1
    end_turn! if @current_phase >= @phases.size
    phase.execute
    world.when_phase_ends
    next! if phase.auto
  end


  def phase
    @phases[@current_phase]
  end

  def phase=(phase_class)
    @phases.each_with_index do |p, i|
      @current_phase = i if p.is_a? phase_class
    end
  end

  def end_turn!
    @current_phase = -1
    world.when_turn_ends
    @number += 1
    next!
  end

end
