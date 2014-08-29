class Dragon < Creature

  def initialize
    super
    @name = "Green Dragon"
    @strength = 7
    @toughness = 4
    @type = "Dragon"
    @cost = 5
    @img = "http://www.literarilycreative.com/wp-content/uploads/2013/03/The_green_dragon_by_Amisgaudi.jpg"
    add_ability(Flying.new)
  end

end
