class Phase

  attr_accessor :name, :turn

  def initialize(turn=nil)
    @turn = turn
  end

  def world
    @turn.world
  end

  def to_s
    @name
  end

  def can_pass_to_next?
    cannot_pass_to_next_because == nil
  end


  def cannot_pass_to_next_because
    nil
  end

  def auto
    true
  end

  def after
  end

end
