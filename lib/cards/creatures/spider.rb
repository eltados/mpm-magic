class Spider < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Giant Spider"
    @strength = 4
    @toughness = 2
    @cost = 3
    @img = "http://cdn.obsidianportal.com/assets/190737/giant_spider.jpg"
    # add_ability(Flying.new)
  end

end
