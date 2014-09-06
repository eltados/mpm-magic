class Spell < Card
  attr_accessor :target

  def initialize(owner=nil)
    super(owner)
  end

  def card
    owner
  end

end
