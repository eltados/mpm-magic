class Post < Phase

  def initialize(options={})
    @name = "Post Combat"
    @action = "play"
  end

  def execute
  end

  def auto
    false
  end

end