class Spider < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Giant Spider"
    @strength = 2
    @toughness = 4
    @cost = 3
    @img = "http://cdn.obsidianportal.com/assets/190737/giant_spider.jpg"
    add_abilities [ Reach ]
  end

end
