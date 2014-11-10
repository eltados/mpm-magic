class WhiteDwarf < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "White Dwarf"
    @strength = 2
    @toughness = 3
    @cost = 3
    @img = "http://magnetica.ru/gallery/wp-content/uploads/Dwarf_Saga_Singer.jpg"
  end

end
