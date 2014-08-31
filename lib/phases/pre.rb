class Pre < Phase

  def initialize(turn=nil)
    super(turn)
    @name = "Pre combat"
  end

  def execute
  end

  def auto
    false
  end

end
