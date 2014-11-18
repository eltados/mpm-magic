class Post < Phase

  def initialize(turn=nil)
    super(turn)
    @name = "After Combat"
  end

  def execute
  end

  def auto
    false
  end

end
