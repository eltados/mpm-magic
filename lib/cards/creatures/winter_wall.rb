class WinterWall < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Winter Wall"
    @strength = 0
    @toughness = 6
    @cost = 4
    @img = "http://img4.wikia.nocookie.net/__cb20110305193555/gameofthrones/images/thumb/f/f5/The_Wall.jpg/500px-The_Wall.jpg"
  end

end
