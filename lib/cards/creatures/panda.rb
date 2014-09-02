class Panda < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Panda"
    @strength = 6
    @toughness = 9
    @type = "Panda"
    @cost = 8
    @img = "http://www.danstapub.com/wp-content/uploads/2013/03/Panda-Baby.jpg"
    add_abilities [Trample]

  end

end
