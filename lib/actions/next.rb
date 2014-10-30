class Next < Action

  def initialize(owner=nil)
    super(owner)
    @name = "Next"
    @img ="next.png"
    @description ="Next"
    @priority =1
  end

  def can_be_activated
    world.stack.empty? &&  player.active? && world.turn.phase.can_pass_to_next?
  end

  def player
     @owner
  end

  def display_name
    return "Start" if phase.is_a?(Draw)
    return "End Turn" if phase.is_a?(Post)
    if phase.is_a?(BlockPhase)
      if player.creatures.find{ |c| c.flags[:blocking] }
        return "Finished Blocking"
      else
        return "Skip Block"
      end
    end
    if phase.is_a?(Combat)
      if player.creatures.find{ |c| c.flags[:attacking] }
        return "Attack"
      else
        return "Skip Combat"
      end
    end
    return "Next"
  end

  def pay!
  end

  def react_time
    return  3000 if phase.is_a?(Untap)
    # return  0 if phase.is_a?(Unkeep)
    # return  3000 if phase.is_a?(Post)
    return  3000 if phase.is_a?(Combat)
    return  4000 if phase.is_a?(Block)
    return  4000 if phase.is_a?(Post)
    2000
  end

  def execute!
    world.turn.next!
  end


end
