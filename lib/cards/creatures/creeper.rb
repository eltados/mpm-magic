class Creeper < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Creeper"
    @strength = 6
    @toughness = 1
    @type = "Creature"
    @cost = 4 # 1B
    @description =  "The night has gone and this Creeper is waiting for you"
    @img = "http://www.doctornerdlove.com/wp-content/uploads/2011/12/minecraft_creeper.jpg"
    @mtg_id = 174835
    add_abilities [Trample]
  end

end
