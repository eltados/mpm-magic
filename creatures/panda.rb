class Panda < Creature

  def initialize
    super
    @name = "Panda"
    @strength = 6
    @toughness = 9
    @type = "Panda"
    @cost = 8
    @img = "http://www.danstapub.com/wp-content/uploads/2013/03/Panda-Baby.jpg"
    # add_ability(Flying.new)
  end

end
