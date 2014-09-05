class Spider < Creature

  def initialize
    super
    @name = "Giant Spider"
    @strength = 4
    @toughness = 2
    @type = "Spider"
    @cost = 3
    @img = "http://cdn.obsidianportal.com/assets/190737/giant_spider.jpg"
    # add_ability(Flying.new)
  end

end
