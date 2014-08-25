require_relative 'phase/phase'
require_relative 'phase/draw'
require_relative 'phase/untap'
require_relative 'phase/unkeep'
require_relative 'phase/discard'
require_relative 'phase/pre'
require_relative 'phase/post'
require_relative 'phase/combat'

class Turn
  attr_accessor :current_phase, :number
  @@phases = [ Untap.new , Unkeep.new, Draw.new , Pre.new , Combat.new, Post.new , Discard.new]


  def initialize
    @current_phase = 0
    @number = 1
  end

  def next!
    @current_phase += 1
    end_turn! if @current_phase >= @@phases.size
    execute_phase
  end

  def execute_phase
    phase.execute
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
