class Pre < Phase

  def initialize(turn=nil)
    super(turn)
    @name = "Before Combat"
  end

  def execute
  end

  def auto
    false
  end

end
