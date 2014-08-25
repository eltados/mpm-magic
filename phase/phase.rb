class Phase

  attr_accessor :name, :action



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


end
